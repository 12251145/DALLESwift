//
//  StateAction.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import ReactorKit

public enum PresentationAction {
    case promtInput(string: String?)    
}

public struct PresentationState {
    var generateButtonEnabled: Bool
        
    public init(generateButtonEnabled: Bool) {
        self.generateButtonEnabled = generateButtonEnabled
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    var action: ActionSubject<PresentationAction> { get }
    var state: Observable<PresentationState> { get }
}
