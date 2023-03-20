//
//  RootRouter.swift
//  Application
//
//  Created by Hoen on 2023/03/19.
//

import BaseDependencyDomain
import FeatureDALLEDomain
import RIBs
import UIKit

protocol RootInteractable: Interactable, FeatureDALLEListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: NavigateViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let dallEBuilder: FeatureDALLEBuilder
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(dallEBuilder: FeatureDALLEBuilder, interactor: RootInteractable, viewController: RootViewControllable) {
        self.dallEBuilder = dallEBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        attachDALLE()
    }
    
    func attachDALLE() {
        
        let dallE = dallEBuilder.build(withListener: interactor)
        attachChild(dallE)
        let dallEVC = dallE.viewControllable

        viewController.presentNavigationViewController(root: dallEVC, modalPresentationStyle: .fullScreen)
    }
}
