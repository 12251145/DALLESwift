//
//  FeatureDALLERouter.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RIBs

protocol FeatureDALLEInteractable: Interactable, ImageResultListener {
    var router: FeatureDALLERouting? { get set }
    var listener: FeatureDALLEListener? { get set }
}

protocol FeatureDALLEViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FeatureDALLERouter: ViewableRouter<FeatureDALLEInteractable, FeatureDALLEViewControllable>, FeatureDALLERouting {
    
    private let imageResultBuilder: ImageResultBuildable
    private var imageRouter: ImageResultRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(imageResultBuilder: ImageResultBuildable, interactor: FeatureDALLEInteractable, viewController: FeatureDALLEViewControllable) {
        self.imageResultBuilder = imageResultBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToImageResult() {
        let router = imageResultBuilder.build(withListener: interactor)
        imageRouter = router
        attachChild(router)
        viewController.uiviewController.present(router.viewControllable.uiviewController, animated: true)
    }
}
