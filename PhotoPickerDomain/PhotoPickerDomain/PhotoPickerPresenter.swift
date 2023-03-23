//
//  PhotoPickerPresenter.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/23.
//

import PhotoPickerUserInterface
import RIBs
import RxRelay
import RxSwift
import UIKit

public final class PhotoPickerPresenter: PhotoPickerPresentable, PhotoPickerViewControllable {
    
    public weak var listener: PhotoPickerPresentableListener? {
        didSet {
            listenerMapper = listener.map(PhotoPickerPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }
    
    public var uiviewController: UIViewController { viewController }
    private let viewController = PhotoPickerViewController()
    
    private var listenerMapper: PhotoPickerPresentableListenerMapper?
    
    init() {}
}

private final class PhotoPickerPresentableListenerMapper: PhotoPickerUserInterface.PhotoPickerPresentableListener, PhotoPickerPresentableListener {
    
    var presentableState: Observable<PhotoPickerUserInterface.PhotoPickerPresentableState>
    
    var action: PublishRelay<PhotoPickerPresentationAction>
    var state: Observable<PhotoPickerPresentationState>
    
    init(interactor: PhotoPickerPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: PhotoPickerUserInterface.PhotoPickerPresentableAction) {
        self.action.accept(userAction.toMapper)
    }
}
