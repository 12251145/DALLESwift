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
    case editMaskButtonTap
}

public struct PresentationState {
    var image: UIImage?
    var mask: UIImage?
    var prompt: String?
    var generateButtonEnabled: Bool
    var keyBoardHeight: CGFloat
    var imageProcessing: Bool
    var pngData: Data?
        
    public init(
        image: UIImage? = nil,
        mask: UIImage? = nil,
        prompt: String? = nil,
        generateButtonEnabled: Bool = false,
        keyBoardHeight: CGFloat = 0,
        imageProcessing: Bool = false,
        pngData: Data? = nil) {
        
            self.image = image
            self.mask = mask
            self.prompt = prompt
            self.generateButtonEnabled = generateButtonEnabled
            self.keyBoardHeight = keyBoardHeight
            self.imageProcessing = imageProcessing
            self.pngData = pngData
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    var action: PublishRelay<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
