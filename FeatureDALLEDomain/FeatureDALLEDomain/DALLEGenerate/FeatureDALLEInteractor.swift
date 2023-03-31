//
//  FeatureDALLEInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import Photos
import RIBs
import RxKeyboard
import RxRelay
import RxSwift
import UIKit
import Util

public protocol FeatureDALLERouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToImageResult()
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

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FeatureDALLEPresentable) {
        self.stateRelay = .init(value: .init(image: nil, generateButtonEnabled: false, keyBoardHeight: 0))
        self.state = stateRelay.asObservable()
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
                    
                    let isEnabled = text.notNilNotEmpty()
                    
                    if var newState = self?.stateRelay.value {
                        newState.generateButtonEnabled = isEnabled
                        self?.stateRelay.accept(newState)
                    }
                    
                case .generateButtonTap:
                    self?.router?.routeToImageResult()
                case .imageButtonTap:
                    self?.router?.routeToPhotoPicker()
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
        self.stateRelay.accept(newState)
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
