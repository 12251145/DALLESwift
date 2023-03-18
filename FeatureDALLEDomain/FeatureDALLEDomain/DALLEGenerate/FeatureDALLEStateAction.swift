//
//  FeatureDALLEStateAction.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RxRelay
import RxSwift

public enum PresentationAction {
    case promtInput(string: String?)
    case generateButtonTap
}

public struct PresentationState {
    var generateButtonEnabled: Bool
        
    public init(generateButtonEnabled: Bool) {
        self.generateButtonEnabled = generateButtonEnabled
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    var action: PublishRelay<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
