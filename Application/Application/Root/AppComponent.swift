//
//  AppComponent.swift
//  Application
//
//  Created by Hoen on 2023/03/19.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
