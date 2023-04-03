//
//  EditMaskInteractor.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import RIBs
import RxRelay
import RxSwift
import UIKit

public protocol EditMaskRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol EditMaskPresentable: Presentable {
    var listener: EditMaskPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol EditMaskListener: AnyObject {
    func setMaskedImage(_ image: UIImage?)
    func detachEditMask()
}

final class EditMaskInteractor: PresentableInteractor<EditMaskPresentable>, EditMaskInteractable, EditMaskPresentableListener {

    weak var router: EditMaskRouting?
    weak var listener: EditMaskListener?
    
    let action = PublishRelay<EditMaskPresentationAction>()
    
    private let stateRelay: BehaviorRelay<EditMaskPresentationState>
    let state: Observable<EditMaskPresentationState>
    
    private let image: UIImage

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: EditMaskPresentable, image: UIImage) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        self.image = image
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
            .subscribe { [weak self] action in
                switch action {
                case .viewDidLoad:
                    
                    if var newState = self?.stateRelay.value {
                        newState.image = self?.image
                        self?.stateRelay.accept(newState)
                    }
                case .imageMasked(let image):
                    self?.listener?.setMaskedImage(image)
                    self?.listener?.detachEditMask()
                }
            }
            .disposeOnDeactivate(interactor: self)
    }
}
