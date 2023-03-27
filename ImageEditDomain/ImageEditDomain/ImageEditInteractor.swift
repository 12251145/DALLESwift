//
//  ImageEditInteractor.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import BaseDependencyDomain
import Photos
import RIBs
import RxRelay
import RxSwift

public protocol ImageEditRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol ImageEditPresentable: Presentable {
    var listener: ImageEditPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol ImageEditListener: AnyObject {
    func detachImageEdit()
}

final class ImageEditInteractor: PresentableInteractor<ImageEditPresentable>, ImageEditInteractable, ImageEditPresentableListener {

    weak var router: ImageEditRouting?
    weak var listener: ImageEditListener?
    
    let action = PublishRelay<ImageEditPresentationAction>()
    
    private let stateRelay: BehaviorRelay<ImageEditPresentationState>
    let state: Observable<ImageEditPresentationState>
    
    private let requestPhotoImageUseCase: RequestPhotoImageUseCase
    
    private let asset: PHAsset

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        requestPhotoImageUseCase: RequestPhotoImageUseCase,
        presenter: ImageEditPresentable,
        asset: PHAsset) {
            self.stateRelay = .init(value: .init())
            self.state = stateRelay.asObservable()
            self.asset = asset
            self.requestPhotoImageUseCase = requestPhotoImageUseCase
            super.init(presenter: presenter)
            presenter.listener = self
        }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        bindAction()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    private func bindAction() {
        action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .viewDidLoad:
                    guard let asset = self?.asset else { return }
                    
                    let targetWidth = asset.pixelWidth
                    let targetHeight = asset.pixelHeight
                    
                    DispatchQueue.global().async {
                        self?.requestPhotoImageUseCase.execute(
                            with: asset,
                            targetSize: .init(
                                width: targetWidth,
                                height: targetHeight)) { [weak self] image in
                                    
                                    if var newState = self?.stateRelay.value {
                                        newState.image = image
                                        self?.stateRelay.accept(newState)
                                    }                                
                            }
                    }
                case .doneButtonDidTap:
                    break
                case .xButtonDidTap:
                    self?.listener?.detachImageEdit()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
}
