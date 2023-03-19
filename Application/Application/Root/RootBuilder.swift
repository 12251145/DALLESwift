//
//  RootBuilder.swift
//  Application
//
//  Created by Hoen on 2023/03/19.
//

import FeatureDALLEDomain
import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, FeatureDALLEDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let dallEBuilder = FeatureDALLEBuilder(dependency: component)
        
        return RootRouter(dallEBuilder: dallEBuilder, interactor: interactor, viewController: viewController)
    }
}
