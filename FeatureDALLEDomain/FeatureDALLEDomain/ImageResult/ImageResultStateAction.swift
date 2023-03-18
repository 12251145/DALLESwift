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
    var image: UIImage?
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    var action: PublishRelay<ImageResultPresentationAction> { get }
    var state: Observable<ImageResultPresentationState> { get }
}
