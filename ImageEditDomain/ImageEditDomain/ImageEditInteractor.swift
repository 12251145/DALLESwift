//
//  ImageEditInteractor.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

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

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ImageEditPresentable) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
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
                    print("vd")
                case .doneButtonDidTap:
                    print("db")
                case .xButtonDidTap:
                    self?.listener?.detachImageEdit()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
}
