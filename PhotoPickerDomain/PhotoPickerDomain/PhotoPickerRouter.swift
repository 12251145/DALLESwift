//
//  PhotoPickerRouter.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import RIBs

public protocol PhotoPickerInteractable: Interactable {
    var router: PhotoPickerRouting? { get set }
    var listener: PhotoPickerListener? { get set }
}

public protocol PhotoPickerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PhotoPickerRouter: ViewableRouter<PhotoPickerInteractable, PhotoPickerViewControllable>, PhotoPickerRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PhotoPickerInteractable, viewController: PhotoPickerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
