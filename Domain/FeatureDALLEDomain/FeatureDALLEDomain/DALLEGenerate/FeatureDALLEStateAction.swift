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
    case nChanged(n: Int)
    case imageEraseDone(image: UIImage)
}

public struct PresentationState {
    var image: UIImage?
    var masked: Bool
    var prompt: String?
    var generateButtonEnabled: Bool
    var keyBoardHeight: CGFloat
    var imageProcessing: Bool
    var pngData: Data?
    var n: Int
        
    public init(
        image: UIImage? = nil,
        masked: Bool = false,
        prompt: String? = nil,
        generateButtonEnabled: Bool = false,
        keyBoardHeight: CGFloat = 0,
        imageProcessing: Bool = false,
        pngData: Data? = nil,
        n: Int = 1
    ) {
        
        self.image = image
        self.masked = masked
        self.prompt = prompt
        self.generateButtonEnabled = generateButtonEnabled
        self.keyBoardHeight = keyBoardHeight
        self.imageProcessing = imageProcessing
        self.pngData = pngData
        self.n = n
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    var action: PublishRelay<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
