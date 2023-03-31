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
}

public struct ImageResultPresentationState {
    var images: [UIImage]
    
    public init(images: [UIImage] = []) {
        self.images = images
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    var action: PublishRelay<ImageResultPresentationAction> { get }
    var state: Observable<ImageResultPresentationState> { get }
}
