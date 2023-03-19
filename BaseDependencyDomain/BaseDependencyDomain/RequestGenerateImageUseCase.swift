//
//  RequestGenerateImageUseCase.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/03/19.
//

import Foundation
import RxSwift
import Swinject
import ThirdPartyLibraryManager
import UIKit

protocol RequestGenerateImageUseCase {
    func execute() async -> UIImage?
}

struct RequestGenerateImageUseCaseImpl: RequestGenerateImageUseCase {
    private let dallERepository: DALLERepository
    
    public init() {
        let container = DIContainer.shared
        guard let dallERepositoryImpl = container.resolve(DALLERepository.self) else {
            fatalError("[RequestGenerateImageUseCaseImpl] SL failed!")
        }
        
        self.dallERepository = dallERepositoryImpl
    }
    
    func execute() async -> UIImage? {
        return await dallERepository.requestGenerateImage()
    }
}
