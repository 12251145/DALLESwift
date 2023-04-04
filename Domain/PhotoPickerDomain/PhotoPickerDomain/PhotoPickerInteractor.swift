//
//  PhotoPickerInteractor.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import BaseDependencyDomain
import Photos
import RIBs
import RxRelay
import RxSwift
import UIKit

public protocol PhotoPickerRouting: ViewableRouting {

}

public protocol PhotoPickerPresentable: Presentable {
    var listener: PhotoPickerPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol PhotoPickerListener: AnyObject {
    func detachPhotoPicker()
    func setImage(_ image: UIImage)
}

final class PhotoPickerInteractor: PresentableInteractor<PhotoPickerPresentable>, PhotoPickerInteractable, PhotoPickerPresentableListener {

    weak var router: PhotoPickerRouting?
    weak var listener: PhotoPickerListener?
    
    let action = PublishRelay<PhotoPickerPresentationAction>()
    
    private let stateRelay: BehaviorRelay<PhotoPickerPresentationState>
    let state: Observable<PhotoPickerPresentationState>
    
    private let requestPhotoImageUseCase: RequestPhotoImageUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(requestPhotoImageUseCase: RequestPhotoImageUseCase, presenter: PhotoPickerPresentable) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        self.requestPhotoImageUseCase = requestPhotoImageUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
            
        bindAction()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    private func bindAction() {
        action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .viewDidLoad:
                    self?.requestAuthorization(completion: { status in
                        
                        switch status {
                        case .notDetermined, .restricted, .denied:
                            break
                        case .limited, .authorized:
                            if var newState = self?.stateRelay.value {
                                
                                let fetchOptions = PHFetchOptions()
                                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                                
                                newState.assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                                newState.showSelectMorePhotoButton = status == .limited ? true : false
                                
                                self?.stateRelay.accept(newState)                                
                            }
                        @unknown default:
                            fatalError("Unknow authorizationstatus")
                        }
                    })
                case .xButtonDidTap:
                    self?.listener?.detachPhotoPicker()
                case .imageEditComplete(let image):
                    self?.listener?.setImage(image)
                case .cropViewDismissed:
                    self?.listener?.detachPhotoPicker()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func requestAuthorization(completion: @escaping (PHAuthorizationStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus)
                }
            }
        default:
            completion(status)
        }
    }

    func requestPhotoImage(asset: PHAsset?, targetSize: CGSize, fetchDegradedAlso: Bool, completion: @escaping (UIImage?) -> Void) {
        requestPhotoImageUseCase.execute(with: asset, targetSize: targetSize, fetchDegradedAlso: fetchDegradedAlso, completion: completion)
    }
}
