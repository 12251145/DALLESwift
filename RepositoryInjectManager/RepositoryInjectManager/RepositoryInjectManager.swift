//
//  RepositoryInjectManager.swift
//  RepositoryInjectManager
//
//  Created by Hoen on 2023/03/19.
//


import DALLEAPI
import FeatureDALLEDomain
import FeatureDALLERepository
import RESTAPI
import ThirdPartyLibraryManager

public final class RepositoryInjectManager {
    
    public static let shared = RepositoryInjectManager()
    
    private init() {        
        DIContainer.shared.register(DALLERepository.self) { _ in
            let network = HTTPNetwork(session: .shared)
            let dallEApi = DALLEAPI(httpNetwork: network)
            
            return DALLERepositoryImpl(dallEApi: dallEApi)
        }
    }
}
