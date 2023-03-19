//
//  RepositoryInjectManager.swift
//  RepositoryInjectManager
//
//  Created by Hoen on 2023/03/19.
//

import FeatureDALLEDomain
import FeatureDALLERepository
import ThirdPartyLibraryManager

public final class RepositoryInjectManager {
    
    public static let shared = RepositoryInjectManager()
    
    private init() {
        DIContainer.shared.register(DALLERepository.self) { _ in
            return DALLERepositoryImpl()
        }
    }
}
