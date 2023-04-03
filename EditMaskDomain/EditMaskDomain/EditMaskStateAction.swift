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
}

public struct EditMaskPresentationState {
    public init() { }
}

public protocol EditMaskPresentableListener: AnyObject {
    var action: PublishRelay<EditMaskPresentationAction> { get }
    var state: Observable<EditMaskPresentationState> { get }
}
