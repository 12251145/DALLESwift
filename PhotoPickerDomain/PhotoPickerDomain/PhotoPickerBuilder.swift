//
//  PhotoPickerBuilder.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import ImageEditDomain
import RIBs

public protocol PhotoPickerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PhotoPickerComponent: Component<PhotoPickerDependency>, ImageEditDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol PhotoPickerBuildable: Buildable {
    func build(withListener listener: PhotoPickerListener) -> PhotoPickerRouting
}

public final class PhotoPickerBuilder: Builder<PhotoPickerDependency>, PhotoPickerBuildable {

    public override init(dependency: PhotoPickerDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: PhotoPickerListener) -> PhotoPickerRouting {
        let component = PhotoPickerComponent(dependency: dependency)
        let viewController = PhotoPickerPresenter()
        let interactor = PhotoPickerInteractor(requestPhotoImageUseCase: RequestPhotoImageUseCaseImpl(), presenter: viewController)
        let imageEditBuilder = ImageEditBuilder(dependency: component)
        interactor.listener = listener
        
        return PhotoPickerRouter(
            imageEditBuilder: imageEditBuilder,
            interactor: interactor,
            viewController: viewController
        )
    }
}
