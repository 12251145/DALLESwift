//
//  ImageResultMapper.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import FeatureDALLEUserInterface

extension FeatureDALLEUserInterface.ImageResultPresentableAction {
    var toMapper: ImageResultPresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        }
    }
}

extension ImageResultPresentationState {
    var toMapper: FeatureDALLEUserInterface.ImageResultPresentableState {
        return .init(image: image)
    }
}
