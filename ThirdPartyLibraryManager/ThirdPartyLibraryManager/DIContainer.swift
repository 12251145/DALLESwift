//
//  DIContainer.swift
//  ThirdPartyLibraryManager
//
//  Created by Hoen on 2023/03/19.
//

import Foundation
import Swinject

public final class DIContainer {
    static public let shared = DIContainer().container
    
    let container = Container()
    
    private init() { }
}
