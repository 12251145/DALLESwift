//
//  PhotoManager.swift
//  PhotoManager
//
//  Created by Hoen on 2023/03/24.
//

import Photos
import UIKit

public final class PhotoManager {
    
    public static let shared = PhotoManager()
    private let phImageManager = PHImageManager()
    
    private init() { }
    
    public func requestImage(with asset: PHAsset?, targetSize: CGSize) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            requestImage(with: asset, targetSize: targetSize) { image in
                continuation.resume(returning: image)
            }
        }
    }
    
    private func requestImage(with asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        guard let asset else {
            completion(nil)
            return
        }
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        
        self.phImageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
            completion(image)
        }
    }
}
