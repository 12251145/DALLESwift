//
//  PhotoRepository.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import Photos
import UIKit

public protocol PhotoRepository {
    func requestImage(with asset: PHAsset?, targetSize: CGSize) async -> UIImage?
}
