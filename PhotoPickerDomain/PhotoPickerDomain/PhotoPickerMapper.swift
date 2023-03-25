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
        case .xButtonDidTap:
            return .xButtonDidTap
        case .imageSelect(let asset):
            return .imageSelect(asset: asset)
        }
    }
}

extension PhotoPickerPresentationState {
    
    // TODO: Return DomainState
    var toMapper: PhotoPickerUserInterface.PhotoPickerPresentableState {
        return .init(assets: assets, showSelectMorePhotoButton: showSelectMorePhotoButton)
    }
}
