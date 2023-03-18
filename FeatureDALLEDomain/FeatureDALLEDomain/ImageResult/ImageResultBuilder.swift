//
//  ImageResultBuilder.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import RIBs


protocol ImageResultDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ImageResultComponent: Component<ImageResultDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ImageResultBuildable: Buildable {
    func build(withListener listener: ImageResultListener) -> ImageResultRouting
}

final class ImageResultBuilder: Builder<ImageResultDependency>, ImageResultBuildable {

    override init(dependency: ImageResultDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ImageResultListener) -> ImageResultRouting {
        let component = ImageResultComponent(dependency: dependency)
        let viewController = ImageResultPresenter()
        let interactor = ImageResultInteractor(presenter: viewController)
        interactor.listener = listener
        return ImageResultRouter(interactor: interactor, viewController: viewController)
    }
}
