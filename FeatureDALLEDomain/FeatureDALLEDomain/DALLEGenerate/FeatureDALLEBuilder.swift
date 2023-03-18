//
//  FeatureDALLEBuilder.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RIBs

protocol FeatureDALLEDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FeatureDALLEComponent: Component<FeatureDALLEDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FeatureDALLEBuildable: Buildable {
    func build(withListener listener: FeatureDALLEListener) -> FeatureDALLERouting
}

final class FeatureDALLEBuilder: Builder<FeatureDALLEDependency>, FeatureDALLEBuildable {

    override init(dependency: FeatureDALLEDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FeatureDALLEListener) -> FeatureDALLERouting {
        let component = FeatureDALLEComponent(dependency: dependency)
        let viewController = FeatureDALLEPresenter()
        let interactor = FeatureDALLEInteractor(presenter: viewController)
        interactor.listener = listener
        return FeatureDALLERouter(interactor: interactor, viewController: viewController)
    }
}
