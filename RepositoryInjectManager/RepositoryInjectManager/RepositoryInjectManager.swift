//
//  RepositoryInjectManager.swift
//  RepositoryInjectManager
//
//  Created by Hoen on 2023/03/19.
//


import BaseDependencyDomain
import DALLEAPI
import FeatureDALLEDomain
import FeatureDALLERepository
import PhotoPickerDomain
import PhotoRepository
import PhotoManager
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
        
        DIContainer.shared.register(PhotoRepository.self) { _ in
            
            return PhotoRepositoryImpl(photoManager: PhotoManager.shared)
        }
    }
}
