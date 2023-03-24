//
//  PhotoPickerInteractor.swift
//  PhotoPickerDomain
//
//  Created by Hoen on 2023/03/24.
//

import Photos
import RIBs
import RxRelay
import RxSwift

public protocol PhotoPickerRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol PhotoPickerPresentable: Presentable {
    var listener: PhotoPickerPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol PhotoPickerListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PhotoPickerInteractor: PresentableInteractor<PhotoPickerPresentable>, PhotoPickerInteractable, PhotoPickerPresentableListener {

    weak var router: PhotoPickerRouting?
    weak var listener: PhotoPickerListener?
    
    let action = PublishRelay<PhotoPickerPresentationAction>()
    
    private let stateRelay: BehaviorRelay<PhotoPickerPresentationState>
    let state: Observable<PhotoPickerPresentationState>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: PhotoPickerPresentable) {
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
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
                                newState.assets = PHAsset.fetchAssets(with: .image, options: .none)
                                self?.stateRelay.accept(newState)                                
                            }
                        @unknown default:
                            fatalError("Unknow authorizationstatus")
                        }
                    })
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
}
