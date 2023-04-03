//
//  EditMaskPresenter.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import EditMaskUserInterface
import RIBs
import RxRelay
import RxSwift
import UIKit

public final class EditMaskPresenter: EditMaskPresentable, EditMaskViewControllable {
    
    public weak var listener: EditMaskPresentableListener? {
        didSet {
            listenerMapper = listener.map(EditMaskPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }
    
    public var uiviewController: UIViewController { viewController }
    private let viewController = EditMaskViewController()
    
    private var listenerMapper: EditMaskPresentableListenerMapper?
    
    init() {}
}

private final class EditMaskPresentableListenerMapper: EditMaskUserInterface.EditMaskPresentableListener, EditMaskPresentableListener {
    
    var presentableState: Observable<EditMaskUserInterface.EditMaskPresentableState>
    
    var action: PublishRelay<EditMaskPresentationAction>
    var state: Observable<EditMaskPresentationState>
    
    init(interactor: EditMaskPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: EditMaskUserInterface.EditMaskPresentableAction) {
        self.action.accept(userAction.toMapper)
    }
}
