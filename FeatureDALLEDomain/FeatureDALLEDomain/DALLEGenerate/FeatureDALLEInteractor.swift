//
//  FeatureDALLEInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import BaseDependencyDomain
import Photos
import RIBs
import RxKeyboard
import RxRelay
import RxSwift
import UIKit
import Util

public protocol FeatureDALLERouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToImageResult(prompt: String?, n: Int, image: Data?, mask: String?)
    func routeToPhotoPicker()
    
    func detachPhotoPicker()    
}

public protocol FeatureDALLEPresentable: Presentable {
    var listener: FeatureDALLEPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol FeatureDALLEListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FeatureDALLEInteractor: PresentableInteractor<FeatureDALLEPresentable>, FeatureDALLEInteractable, FeatureDALLEPresentableListener {
    
    let action = PublishRelay<PresentationAction>()
    
    private let stateRelay: BehaviorRelay<PresentationState>
    let state: Observable<PresentationState>
    
    weak var router: FeatureDALLERouting?
    weak var listener: FeatureDALLEListener?
    
    private let downSamplingImageDataUseCase: DownSamplingImageDataUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        downSamplingImageDataUseCase: DownSamplingImageDataUseCase,
        presenter: FeatureDALLEPresentable
    ) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        self.downSamplingImageDataUseCase = downSamplingImageDataUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
            
        bindAction()
        observeKeyboard()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func bindAction() {
        action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .promtInput(let text):
                                                            
                    if var newState = self?.stateRelay.value {
                        let isEnabled = text.notNilNotEmpty() || newState.image != nil
                        newState.generateButtonEnabled = isEnabled
                        newState.prompt = text
                        self?.stateRelay.accept(newState)
                    }
                    
                case .generateButtonTap:
                    if let newState = self?.stateRelay.value {
                        self?.router?.routeToImageResult(
                            prompt: newState.prompt,
                            n: 1,
                            image: newState.pngData,
                            mask: nil
                        )
                    }
                case .imageButtonTap:
                    self?.router?.routeToPhotoPicker()
                case .imageXButtonTap:
                    if var newState = self?.stateRelay.value {
                        let isEnabled = newState.prompt.notNilNotEmpty()
                        newState.generateButtonEnabled = isEnabled
                        newState.image = nil
                        self?.stateRelay.accept(newState)
                    }
                }
            })
            .disposeOnDeactivate(interactor: self)                
    }
    
    func detachPhotoPicker() {
        router?.detachPhotoPicker()
    }
    
    func setImage(_ image: UIImage) {
        var newState = stateRelay.value
        newState.image = image
        newState.generateButtonEnabled = false
        newState.imageProcessing = true
        self.stateRelay.accept(newState)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            var completeState = newState
            guard let imageData = image.pngData() else {
                completeState.image = nil
                self?.stateRelay.accept(completeState)
                return
            }
            let result = self?.downSamplingImageDataUseCase.execute(data: imageData, originSize: image.size, maxMB: 4)
            
            completeState.image = result?.image
            completeState.pngData = result?.data
            completeState.generateButtonEnabled = true
            completeState.imageProcessing = false
            
            self?.stateRelay.accept(completeState)
            
        }
        
    }
    
    func observeKeyboard() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                if var newState = self?.stateRelay.value {
                    newState.keyBoardHeight = height
                    self?.stateRelay.accept(newState)
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
}
