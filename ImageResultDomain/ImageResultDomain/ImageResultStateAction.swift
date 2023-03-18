//
//  ImageResultStateAction.swift
//  ImageResultDomain
//
//  Created by Hoen on 2023/03/18.
//

import RxRelay
import RxSwift
import UIKit

public enum PresentationAction {
    case viewDidLoad
}

public struct PresentationState {
    var image: UIImage?
    
    init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    var action: PublishRelay<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
