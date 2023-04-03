//
//  EditMaskMapper.swift
//  EditMaskDomain
//
//  Created by Hoen on 2023/04/03.
//

import EditMaskUserInterface

extension EditMaskUserInterface.EditMaskPresentableAction {
    
    // TODO: Convert UserInterfaceAction -> DomainAction
    var toMapper: EditMaskPresentationAction {
        switch self {
        case .viewDidLoad:
            return .viewDidLoad
        }
    }
}

extension EditMaskPresentationState {
    
    // TODO: Return DomainState
    var toMapper: EditMaskUserInterface.EditMaskPresentableState {

        return .init(image: image)
    }
}
