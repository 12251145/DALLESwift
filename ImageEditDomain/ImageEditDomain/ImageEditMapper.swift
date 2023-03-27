//
//  ImageEditMapper.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import ImageEditUserInterface

extension ImageEditUserInterface.ImageEditPresentableAction {
    
    // TODO: Convert UserInterfaceAction -> DomainAction
    var toMapper: ImageEditPresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        case .doneButtonDidTap:
            return .doneButtonDidTap
        case .xButtonDidTap:
            return .xButtonDidTap
        }
    }
}

extension ImageEditPresentationState {
    
    // TODO: Return DomainState
    var toMapper: ImageEditUserInterface.ImageEditPresentableState {

        return .init(image: image)
    }
}
