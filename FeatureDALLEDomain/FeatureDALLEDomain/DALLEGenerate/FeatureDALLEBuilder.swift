//
//  FeatureDALLEBuilder.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RIBs

public protocol FeatureDALLEDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FeatureDALLEComponent: Component<FeatureDALLEDependency>, ImageResultDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol FeatureDALLEBuildable: Buildable {
    func build(withListener listener: FeatureDALLEListener) -> FeatureDALLERouting
}

public final class FeatureDALLEBuilder: Builder<FeatureDALLEDependency>, FeatureDALLEBuildable {

    public override init(dependency: FeatureDALLEDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: FeatureDALLEListener) -> FeatureDALLERouting {
        let component = FeatureDALLEComponent(dependency: dependency)
        let viewController = FeatureDALLEPresenter()
        let interactor = FeatureDALLEInteractor(presenter: viewController)
        interactor.listener = listener
        
        let imageResultBuilder = ImageResultBuilder(dependency: component)
        
        return FeatureDALLERouter(imageResultBuilder: imageResultBuilder, interactor: interactor, viewController: viewController)
    }
}
