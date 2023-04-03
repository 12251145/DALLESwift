//
//  EditMaskBuilder.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import RIBs

public protocol EditMaskDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditMaskComponent: Component<EditMaskDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol EditMaskBuildable: Buildable {
    func build(withListener listener: EditMaskListener) -> EditMaskRouting
}

public final class EditMaskBuilder: Builder<EditMaskDependency>, EditMaskBuildable {

    public override init(dependency: EditMaskDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: EditMaskListener) -> EditMaskRouting {
        let component = EditMaskComponent(dependency: dependency)
        let viewController = EditMaskPresenter()
        let interactor = EditMaskInteractor(presenter: viewController)
        interactor.listener = listener
        return EditMaskRouter(interactor: interactor, viewController: viewController)
    }
}
