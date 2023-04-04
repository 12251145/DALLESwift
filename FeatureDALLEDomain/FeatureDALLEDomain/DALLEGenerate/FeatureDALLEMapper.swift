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
        case .imageButtonTap:
            return .imageButtonTap
        case .imageXButtonTap:
            return .imageXButtonTap
        case .editMaskButtonTap:
            return .editMaskButtonTap
        }
    }
}

extension PresentationState {
    var toMapper: FeatureDALLEUserInterface.FeatureDALLEPresentableState {
        return .init(image: image, mask: mask, prompt: prompt, generateButtonEnabled: generateButtonEnabled, keyBoardHeight: keyBoardHeight, imageProcessing: imageProcessing, pngData: pngData, maskPngData: maskPngData)
    }
}
