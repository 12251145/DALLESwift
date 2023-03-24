//
//  PhotoPickerMapper.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import PhotoPickerUserInterface

extension PhotoPickerUserInterface.PhotoPickerPresentableAction {
    
    // TODO: Convert UserInterfaceAction -> DomainAction
    var toMapper: PhotoPickerPresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        }
    }
}

extension PhotoPickerPresentationState {
    
    // TODO: Return DomainState
    var toMapper: PhotoPickerUserInterface.PhotoPickerPresentableState {
        return .init()
    }
}
