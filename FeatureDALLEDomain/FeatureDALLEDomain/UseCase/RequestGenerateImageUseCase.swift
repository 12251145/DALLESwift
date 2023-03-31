//
//  RequestGenerateImageUseCase.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/19.
//

import Foundation
import RxSwift
import Swinject
import ThirdPartyLibraryManager
import UIKit


protocol RequestGenerateImageUseCase {
    func execute(prompt: String?, n: Int, image: String?, mask: String?) async throws -> [UIImage]
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
    
    func execute(prompt: String?, n: Int, image: String?, mask: String?) async throws -> [UIImage] {
        return try await dallERepository.requestGenerateImage(prompt: prompt, n: n, image: image, mask: mask)
    }
}
