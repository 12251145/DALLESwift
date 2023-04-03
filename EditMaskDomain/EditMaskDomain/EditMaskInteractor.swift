//
//  EditMaskInteractor.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import RIBs
import RxRelay
import RxSwift

public protocol EditMaskRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol EditMaskPresentable: Presentable {
    var listener: EditMaskPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol EditMaskListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EditMaskInteractor: PresentableInteractor<EditMaskPresentable>, EditMaskInteractable, EditMaskPresentableListener {

    weak var router: EditMaskRouting?
    weak var listener: EditMaskListener?
    
    let action = PublishRelay<EditMaskPresentationAction>()
    
    private let stateRelay: BehaviorRelay<EditMaskPresentationState>
    let state: Observable<EditMaskPresentationState>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EditMaskPresentable) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
