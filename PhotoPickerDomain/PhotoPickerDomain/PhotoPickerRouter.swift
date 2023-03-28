//
//  PhotoPickerRouter.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import BaseDependencyDomain
import ImageEditDomain
import Photos
import RIBs

public protocol PhotoPickerInteractable: Interactable, ImageEditListener {
    var router: PhotoPickerRouting? { get set }
    var listener: PhotoPickerListener? { get set }
    
    func completeImagePick(asset: PHAsset, rect: CGRect)
}

public protocol PhotoPickerViewControllable: NavigateViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PhotoPickerRouter: ViewableRouter<PhotoPickerInteractable, PhotoPickerViewControllable>, PhotoPickerRouting {

    private let imageEditBuilder: ImageEditBuildable
    private var imageEditRouter: ImageEditRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        imageEditBuilder: ImageEditBuildable,
        interactor: PhotoPickerInteractable,
        viewController: PhotoPickerViewControllable) {
            self.imageEditBuilder = imageEditBuilder
            super.init(interactor: interactor, viewController: viewController)
            interactor.router = self
        }
    
    func routeToImageEdit(asset: PHAsset) {
        guard imageEditRouter == nil else { return }
        let router = imageEditBuilder.build(withListener: interactor, asset: asset)
        imageEditRouter = router
        attachChild(router)
        viewController.presentViewController(viewController: router.viewControllable, modalPresentationStyle: .fullScreen)
    }
    
    func detachImageEdit() {
        guard let router = imageEditRouter else { return }
        router.viewControllable.uiviewController.dismiss(animated: true)
        detachChild(router)
        imageEditRouter = nil
    }
    
    func doneImageEdit(asset: PHAsset, rect: CGRect) {
        
        guard let router = imageEditRouter else { return }                
        
        router.viewControllable.uiviewController.dismiss(animated: true) { [weak self] in
            self?.interactor.completeImagePick(asset: asset, rect: rect)
            self?.detachChild(router)
            self?.imageEditRouter = nil
        }
    }
}
