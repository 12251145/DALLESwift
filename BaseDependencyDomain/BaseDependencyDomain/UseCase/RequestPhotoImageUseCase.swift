//
//  RequestPhotoImageUseCase.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/03/27.
//

import Foundation
import RxSwift
import Photos
import Swinject
import ThirdPartyLibraryManager
import UIKit


public protocol RequestPhotoImageUseCase {
    func execute(with asset: PHAsset?, targetSize: CGSize, fetchDegradedAlso: Bool, completion: @escaping (UIImage?) -> Void)
}

public struct RequestPhotoImageUseCaseImpl: RequestPhotoImageUseCase {
    private let photoRepository: PhotoRepository
    
    public init() {
        let container = DIContainer.shared
        guard let photoRepositoryImpl = container.resolve(PhotoRepository.self) else {
            fatalError("[RequestPhotoImageUseCaseImpl] SL failed!")
        }
        
        self.photoRepository = photoRepositoryImpl
    }

    public func execute(with asset: PHAsset?, targetSize: CGSize, fetchDegradedAlso: Bool = true, completion: @escaping (UIImage?) -> Void) {
        photoRepository.requestImage(with: asset, targetSize: targetSize, fetchDegradedAlso: fetchDegradedAlso, completion: completion)
    }
}
