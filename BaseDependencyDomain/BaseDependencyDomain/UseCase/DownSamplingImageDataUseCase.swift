//
//  DownSamplingImageDataUseCase.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/04/01.
//

import Foundation
import ImageIO
import UIKit

public protocol DownSamplingImageDataUseCase {
    func execute(data: Data, originSize: CGSize, maxMB: Double) -> (data: Data, image: UIImage)?
}

public final class DownSamplingImageDataUseCaseImpl: DownSamplingImageDataUseCase {
    
    public init() { }
    
    public func execute(data: Data, originSize: CGSize, maxMB: Double) -> (data: Data, image: UIImage)? {
                
        let scale = UIScreen.main.scale
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
            return nil
        }
        
        var image: UIImage?
        var downSampled = data
        var currentDataSize = data.count
        var targetSize = originSize
        
        while Double(currentDataSize) / 1024 / 1024 >= maxMB {
            let downWidth = targetSize.width / 2
            let downHeight = targetSize.height / 2
            targetSize = .init(width: downWidth, height: downHeight)
            
            let maxDimensionInPixels = max(targetSize.width, targetSize.height) * scale
            let downSampleOptions = [
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
            ] as CFDictionary
            
            guard let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions) else {
                return nil
            }
            
            image = UIImage(cgImage: downSampledImage)
            guard let newData = image?.pngData() else { return nil }
            
            downSampled = newData
            currentDataSize = newData.count
        }
        
        guard let image else { return nil }
        
        return (downSampled, image)
    }
}

