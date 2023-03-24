//
//  PhotoRepositoryImpl.swift
//  PhotoRepository
//
//  Created by Hoen on 2023/03/24.
//

import Photos
import PhotoManager
import PhotoPickerDomain
import UIKit

public struct PhotoRepositoryImpl: PhotoRepository {
    private let photoManager: PhotoManager
    
    public init(photoManager: PhotoManager) {
        self.photoManager = photoManager
    }
    
    public func requestImage(with asset: PHAsset?, targetSize: CGSize) async -> UIImage? {
        return await photoManager.requestImage(with: asset, targetSize: targetSize)
    }
}
