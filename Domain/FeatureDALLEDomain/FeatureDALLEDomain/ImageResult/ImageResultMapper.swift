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
        case .variationButtonDidTap(let image):
            return .variationButtonDidTap(image: image)
        case .xButtonDidTap:
            return .xButtonDidTap
        }
    }
}

extension ImageResultPresentationState {
    var toMapper: ImageResultUserInterface.ImageResultPresentableState {
        return .init(images: images, variationButtonEnabled: variationButtonEnabled)
    }
}
