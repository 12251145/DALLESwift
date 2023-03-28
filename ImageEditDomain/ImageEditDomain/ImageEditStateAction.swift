//
//  ImageEditStateAction.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import RxRelay
import RxSwift
import UIKit

public enum ImageEditPresentationAction {
    case viewDidLoad
    case doneButtonDidTap(rect: CGRect)
    case xButtonDidTap
}

public struct ImageEditPresentationState {
    var image: UIImage?
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol ImageEditPresentableListener: AnyObject {
    var action: PublishRelay<ImageEditPresentationAction> { get }
    var state: Observable<ImageEditPresentationState> { get }
}
