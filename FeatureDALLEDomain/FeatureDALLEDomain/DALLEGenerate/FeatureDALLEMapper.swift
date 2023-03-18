//
//  FeatureDALLEMapper.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import FeatureDALLEUserInterface

extension FeatureDALLEUserInterface.FeatureDALLEPresentableAction {
    var toMapper: PresentationAction {
        switch self {
        case .promtInput(let string):
            return .promtInput(string: string)
        case .generateButtonTap:
            return .generateButtonTap
        }
    }
}

extension PresentationState {
    var toMapper: FeatureDALLEUserInterface.FeatureDALLEPresentableState {
        return .init(generateButtonEnabled: generateButtonEnabled)
    }
}
