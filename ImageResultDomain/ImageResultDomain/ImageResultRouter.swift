//
//  ImageResultRouter.swift
//  ImageResultDomain
//
//  Created by Hoen on 2023/03/18.
//

import RIBs

protocol ImageResultInteractable: Interactable {
    var router: ImageResultRouting? { get set }
    var listener: ImageResultListener? { get set }
}

protocol ImageResultViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ImageResultRouter: ViewableRouter<ImageResultInteractable, ImageResultViewControllable>, ImageResultRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ImageResultInteractable, viewController: ImageResultViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
