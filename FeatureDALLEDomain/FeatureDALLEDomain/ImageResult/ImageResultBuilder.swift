//
//  ImageResultBuilder.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import RIBs


public protocol ImageResultDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ImageResultComponent: Component<ImageResultDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol ImageResultBuildable: Buildable {
    func build(
        withListener listener: ImageResultListener,
        prompt: String?,
        n: Int,
        image: Data?,
        mask: String?
    ) -> ImageResultRouting
}

public final class ImageResultBuilder: Builder<ImageResultDependency>, ImageResultBuildable {

    override init(dependency: ImageResultDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: ImageResultListener,
        prompt: String?,
        n: Int,
        image: Data?,
        mask: String?
    ) -> ImageResultRouting {
        let component = ImageResultComponent(dependency: dependency)
        let viewController = ImageResultPresenter()
        let interactor = ImageResultInteractor(
            generateImageUseCase: RequestGenerateImageUseCaseImpl(),
            presenter: viewController,
            prompt: prompt,
            n: n,
            image: image,
            mask: mask
        )
        interactor.listener = listener
        return ImageResultRouter(interactor: interactor, viewController: viewController)
    }
}
