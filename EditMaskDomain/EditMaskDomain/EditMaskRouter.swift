//
//  EditMaskRouter.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import RIBs

public protocol EditMaskInteractable: Interactable {
    var router: EditMaskRouting? { get set }
    var listener: EditMaskListener? { get set }
}

public protocol EditMaskViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditMaskRouter: ViewableRouter<EditMaskInteractable, EditMaskViewControllable>, EditMaskRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditMaskInteractable, viewController: EditMaskViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
