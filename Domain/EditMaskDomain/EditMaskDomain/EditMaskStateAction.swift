//
//  EditMaskStateAction.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import RxRelay
import RxSwift
import UIKit

public enum EditMaskPresentationAction {
    case viewDidLoad
    case imageMasked(image: UIImage?)
}

public struct EditMaskPresentationState {
    var image: UIImage?
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol EditMaskPresentableListener: AnyObject {
    var action: PublishRelay<EditMaskPresentationAction> { get }
    var state: Observable<EditMaskPresentationState> { get }
}
