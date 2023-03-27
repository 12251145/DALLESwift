//
//  ImageEditBuilder.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import Photos
import RIBs

public protocol ImageEditDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ImageEditComponent: Component<ImageEditDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol ImageEditBuildable: Buildable {
    func build(withListener listener: ImageEditListener, asset: PHAsset) -> ImageEditRouting
}

public final class ImageEditBuilder: Builder<ImageEditDependency>, ImageEditBuildable {

    public override init(dependency: ImageEditDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: ImageEditListener,
        asset: PHAsset) -> ImageEditRouting {
            let component = ImageEditComponent(dependency: dependency)
            let viewController = ImageEditPresenter()
            let interactor = ImageEditInteractor(presenter: viewController, asset: asset)
            interactor.listener = listener
            return ImageEditRouter(interactor: interactor, viewController: viewController)
        }
}
