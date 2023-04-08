//
//  ImageResultStateAction.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import RxRelay
import RxSwift
import UIKit

public enum ImageResultPresentationAction {
    case viewDidLoad
    case variationButtonDidTap(image: UIImage)
    case xButtonDidTap
}

public struct ImageResultPresentationState {
    var images: [UIImage]
    var variationButtonEnabled: Bool
    
    public init(images: [UIImage] = [], variationButtonEnabled: Bool = false) {
        self.images = images
        self.variationButtonEnabled = variationButtonEnabled
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    var action: PublishRelay<ImageResultPresentationAction> { get }
    var state: Observable<ImageResultPresentationState> { get }
}
