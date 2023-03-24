//
//  RequestPhotoImageUseCase.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import Foundation
import RxSwift
import Photos
import Swinject
import ThirdPartyLibraryManager
import UIKit


protocol RequestPhotoImageUseCase {    
    func execute(with asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void)
}

struct RequestPhotoImageUseCaseImpl: RequestPhotoImageUseCase {
    private let photoRepository: PhotoRepository
    
    public init() {
        let container = DIContainer.shared
        guard let photoRepositoryImpl = container.resolve(PhotoRepository.self) else {
            fatalError("[RequestPhotoImageUseCaseImpl] SL failed!")
        }
        
        self.photoRepository = photoRepositoryImpl
    }

    func execute(with asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        photoRepository.requestImage(with: asset, targetSize: targetSize, completion: completion)
    }
}
