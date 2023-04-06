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
    
    func routeToImageResult(prompt: String?, n: Int, image: Data?, masked: Bool)
    func routeToPhotoPicker()
    
    func detachPhotoPicker()
}

public protocol FeatureDALLEPresentable: Presentable {
    var listener: FeatureDALLEPresentableListener? { get set }
    
    func presentImageEraser(with image: UIImage)
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
                    if let currentState = self?.stateRelay.value {
                        
                        if currentState.mask == nil {

                            self?.router?.routeToImageResult(
                                prompt: currentState.prompt,
                                n: currentState.n,
                                image: currentState.pngData,
                                masked: false
                            )
                        } else {
                            self?.router?.routeToImageResult(
                                prompt: currentState.prompt,
                                n: currentState.n,
                                image: currentState.maskPngData,
                                masked: true
                            )
                        }
                    }
                case .imageButtonTap:
                    self?.router?.routeToPhotoPicker()
                case .imageXButtonTap:
                    if var newState = self?.stateRelay.value {
                        let isEnabled = newState.prompt.notNilNotEmpty()
                        newState.generateButtonEnabled = isEnabled
                        newState.image = nil
                        newState.mask = nil
                        self?.stateRelay.accept(newState)
                    }
                    
                case .editMaskButtonTap:
                    if let currentState = self?.stateRelay.value {
                        if let mask = currentState.mask {
                            self?.presenter.presentImageEraser(with: mask)
                        } else if let image = currentState.image {
                            self?.presenter.presentImageEraser(with: image)                            
                        }
                    }
                    
                case .nChanged(let n):
                    if var currentState = self?.stateRelay.value {
                        currentState.n = n
                        self?.stateRelay.accept(currentState)
                    }
                }
            })
            .disposeOnDeactivate(interactor: self)                
    }
    
    func detachPhotoPicker() {
        router?.detachPhotoPicker()
    }
    
    func setImage(_ image: UIImage) {
        
        ///  우선 imageProcessing 상태 전달
        var newState = stateRelay.value
        newState.image = image
        newState.generateButtonEnabled = false
        newState.imageProcessing = true
        self.stateRelay.accept(newState)
        
        ///  Background에서 이미지 프로세싱
        ///  pngData로 변환 후 downSampling 진행
        ///  만약 정사각형 아니라면 resizing 후 다시 downSampling
        ///  완료 상태 전달
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            var completeState = newState
            
            guard let imageData = image.pngData() else {
                completeState.image = nil
                self?.stateRelay.accept(completeState)
                return
            }
            
            var result = self?.downSamplingImageDataUseCase.execute(data: imageData, originImage: image, maxMB: 4)
            
            var downSampledImage = result?.image
            
            if let isSquare = self?.isImageSquare(downSampledImage), !isSquare {
                if let width = downSampledImage?.size.width {
                    
                    downSampledImage = downSampledImage?.resize(to: .init(width: width, height: width))
                    
                    if let downSampledImage, let correctData = downSampledImage.pngData() {
                        result = self?.downSamplingImageDataUseCase.execute(data: correctData, originImage: downSampledImage, maxMB: 4)
                    }
                }
            }
            
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

// MARK: - Private functions
private extension FeatureDALLEInteractor {
    func isImageSquare(_ image: UIImage?) -> Bool {
        guard let image else { return false }
        
        return image.size.width == image.size.height
    }
}
