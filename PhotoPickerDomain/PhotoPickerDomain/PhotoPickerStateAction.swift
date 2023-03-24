//
//  PhotoPickerStateAction.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import RxRelay
import RxSwift
import UIKit

public enum PhotoPickerPresentationAction {
    case viewDidLoad
}

public struct PhotoPickerPresentationState {
    public init() { }
}

public protocol PhotoPickerPresentableListener: AnyObject {
    var action: PublishRelay<PhotoPickerPresentationAction> { get }
    var state: Observable<PhotoPickerPresentationState> { get }
}
