//
//  FeatureDALLERouter.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RIBs

protocol FeatureDALLEInteractable: Interactable {
    var router: FeatureDALLERouting? { get set }
    var listener: FeatureDALLEListener? { get set }
}

protocol FeatureDALLEViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FeatureDALLERouter: ViewableRouter<FeatureDALLEInteractable, FeatureDALLEViewControllable>, FeatureDALLERouting {        

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FeatureDALLEInteractable, viewController: FeatureDALLEViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
