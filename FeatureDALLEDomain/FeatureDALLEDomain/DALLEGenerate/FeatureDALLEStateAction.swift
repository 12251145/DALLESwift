//
//  FeatureDALLEStateAction.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RxRelay
import RxSwift
import UIKit

public enum PresentationAction {
    case promtInput(string: String?)
    case generateButtonTap
    case imageButtonTap
    case imageXButtonTap
}

public struct PresentationState {
    var image: UIImage?
    var prompt: String?
    var generateButtonEnabled: Bool
    var keyBoardHeight: CGFloat
    var pngData: Data?
        
    public init(
        image: UIImage?,
        prompt: String?,
        generateButtonEnabled: Bool,
        keyBoardHeight: CGFloat) {
        
            self.image = image
            self.prompt = prompt
            self.generateButtonEnabled = generateButtonEnabled
            self.keyBoardHeight = keyBoardHeight
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    var action: PublishRelay<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
