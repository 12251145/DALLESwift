//
//  PhotoPickerStateAction.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import Photos
import RxRelay
import RxSwift
import UIKit

public enum PhotoPickerPresentationAction {
    case viewDidLoad
    case xButtonDidTap
    case imageSelect(asset: PHAsset)
}

public struct PhotoPickerPresentationState {
    
    var assets: PHFetchResult<PHAsset>?
    var showSelectMorePhotoButton: Bool
    
    public init(assets: PHFetchResult<PHAsset>? = nil, showSelectMorePhotoButton: Bool = false) {
        self.assets = assets
        self.showSelectMorePhotoButton = showSelectMorePhotoButton
    }
}

public protocol PhotoPickerPresentableListener: AnyObject {
    var action: PublishRelay<PhotoPickerPresentationAction> { get }
    var state: Observable<PhotoPickerPresentationState> { get }
        
    func requestPhotoImage(asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void)
}
