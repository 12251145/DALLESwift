//
//  FeatureDALLERouter.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import BaseDependencyDomain
import Photos
import PhotoPickerDomain
import EditMaskDomain
import RIBs
import UIKit

public protocol FeatureDALLEInteractable: Interactable, ImageResultListener, PhotoPickerListener, EditMaskListener {
    var router: FeatureDALLERouting? { get set }
    var listener: FeatureDALLEListener? { get set }
}

public protocol FeatureDALLEViewControllable: NavigateViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FeatureDALLERouter: ViewableRouter<FeatureDALLEInteractable, FeatureDALLEViewControllable>, FeatureDALLERouting {
    
    private let imageResultBuilder: ImageResultBuildable
    private var imageRouter: ImageResultRouting?
    
    private let editMaskBuilder: EditMaskBuildable
    private var editMaskRouter: EditMaskRouting?
    
    private let photoPickerBuilder: PhotoPickerBuilder
    private var photoPickerRouter: PhotoPickerRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        imageResultBuilder: ImageResultBuildable,
        photoPickerBuilder: PhotoPickerBuilder,
        editMaskBuilder: EditMaskBuildable,
        interactor: FeatureDALLEInteractable,
        viewController: FeatureDALLEViewControllable) {
            
            self.imageResultBuilder = imageResultBuilder
            self.photoPickerBuilder = photoPickerBuilder
            self.editMaskBuilder = editMaskBuilder
            
            super.init(interactor: interactor, viewController: viewController)
            interactor.router = self
        }
    
    func routeToImageResult(prompt: String? , n: Int, image: Data?, mask: String?) {
        let router = imageResultBuilder.build(withListener: interactor, prompt: prompt, n: n, image: image, mask: mask)
        imageRouter = router
        attachChild(router)
        viewController.presentViewController(viewController: router.viewControllable, modalPresentationStyle: .automatic)
    }
    
    func routeToPhotoPicker() {
        let router = photoPickerBuilder.build(withListener: interactor)
        photoPickerRouter = router
        attachChild(router)
        viewController.presentViewController(viewController: router.viewControllable, modalPresentationStyle: .fullScreen)
    }
    
    func routeToEditMask(image: UIImage) {
        guard editMaskRouter == nil else { return }
        let router = editMaskBuilder.build(withListener: interactor, image: image)
        editMaskRouter = router
        attachChild(router)
        viewController.presentViewController(viewController: router.viewControllable, modalPresentationStyle: .fullScreen)
    }
    
    func detachPhotoPicker() {
        guard let router = photoPickerRouter else { return }
        router.viewControllable.uiviewController.dismiss(animated: true)
        detachChild(router)
        photoPickerRouter = nil
    }
    
    func detachEditMask() {
        guard let router = editMaskRouter else { return }
        router.viewControllable.uiviewController.dismiss(animated: true)
        detachChild(router)
        editMaskRouter = nil
    }
}
