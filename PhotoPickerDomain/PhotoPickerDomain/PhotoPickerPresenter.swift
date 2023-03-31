//
//  PhotoPickerPresenter.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import Photos
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
    
    private weak var interactor: PhotoPickerPresentableListener?
    
    var presentableState: Observable<PhotoPickerUserInterface.PhotoPickerPresentableState>
    
    var action: PublishRelay<PhotoPickerPresentationAction>
    var state: Observable<PhotoPickerPresentationState>
    
    init(interactor: PhotoPickerPresentableListener) {
        self.interactor = interactor
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: PhotoPickerUserInterface.PhotoPickerPresentableAction) {
        self.action.accept(userAction.toMapper)
    }

    func requestPhotoImage(asset: PHAsset?, targetSize: CGSize, fetchDegradedAlso: Bool, completion: @escaping (UIImage?) -> Void) {
        interactor?.requestPhotoImage(asset: asset, targetSize: targetSize, fetchDegradedAlso: fetchDegradedAlso, completion: completion)
    }
}
