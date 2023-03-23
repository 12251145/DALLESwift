//
//  ImageResultMapper.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import ImageResultUserInterface

extension ImageResultUserInterface.ImageResultPresentableAction {
    var toMapper: ImageResultPresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        }
    }
}

extension ImageResultPresentationState {
    var toMapper: ImageResultUserInterface.ImageResultPresentableState {
        return .init(image: image)
    }
}
