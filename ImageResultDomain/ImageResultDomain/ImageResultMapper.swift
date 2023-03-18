//
//  ImageResultMapper.swift
//  ImageResultDomain
//
//  Created by Hoen on 2023/03/18.
//

import ImageResultUserInterface

extension ImageResultUserInterface.ImageResultPresentableAction {
    var toMapper: PresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        }
    }
}

extension PresentationState {
    var toMapper: ImageResultUserInterface.ImageResultPresentableState {
        return .init()
    }
}
