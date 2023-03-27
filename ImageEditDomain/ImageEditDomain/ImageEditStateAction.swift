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
    case doneButtonDidTap
    case xButtonDidTap
}

public struct ImageEditPresentationState {
    public init() { }
}

public protocol ImageEditPresentableListener: AnyObject {
    var action: PublishRelay<ImageEditPresentationAction> { get }
    var state: Observable<ImageEditPresentationState> { get }
}
