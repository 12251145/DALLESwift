//
//  NavigateViewControllable.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/03/20.
//

import RIBs
import UIKit

public protocol NavigateViewControllable: ViewControllable {
    func presentViewController(viewController: ViewControllable, modalPresentationStyle: UIModalPresentationStyle)
    func presentNavigationViewController(root: ViewControllable, modalPresentationStyle: UIModalPresentationStyle)
    func dismissViewController(viewController: ViewControllable)
    func pushViewController(viewController: ViewControllable)
    func popViewController(viewController: ViewControllable)
}

public extension NavigateViewControllable {
    func presentViewController(viewController: ViewControllable, modalPresentationStyle: UIModalPresentationStyle) {
        viewController.uiviewController.modalPresentationStyle = modalPresentationStyle
        uiviewController.present(viewController.uiviewController, animated: true, completion: nil)
    }
    func presentNavigationViewController(root: ViewControllable, modalPresentationStyle: UIModalPresentationStyle) {
        let navi = UINavigationController(rootViewController: root.uiviewController)
        navi.modalPresentationStyle = modalPresentationStyle
        uiviewController.present(navi, animated: false, completion: nil)
    }
    func dismissViewController(viewController: ViewControllable) {
        viewController.uiviewController.dismiss(animated: true, completion: nil)
    }
    func pushViewController(viewController: ViewControllable) {
        uiviewController.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    func popViewController(viewController: ViewControllable) {
        uiviewController.navigationController?.popToViewController(uiviewController, animated: true)
    }
}
