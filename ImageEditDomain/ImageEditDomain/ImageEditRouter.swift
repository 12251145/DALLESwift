//
//  ImageEditRouter.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import RIBs

public protocol ImageEditInteractable: Interactable {
    var router: ImageEditRouting? { get set }
    var listener: ImageEditListener? { get set }
}

public protocol ImageEditViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ImageEditRouter: ViewableRouter<ImageEditInteractable, ImageEditViewControllable>, ImageEditRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ImageEditInteractable, viewController: ImageEditViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
