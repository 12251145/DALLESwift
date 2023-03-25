//
//  PhotoPickerViewController.swift
//  PhotoPickerUserInterface
//
//  Created by Hoen on 2023/03/24.
//

import DesignSystem
import Photos
import PhotosUI
import RxCocoa
import RxRelay
import RxSwift
import UIKit

public enum PhotoPickerPresentableAction {
    case viewDidLoad
    case xButtonDidTap
}

public struct PhotoPickerPresentableState {
    
    var assets: PHFetchResult<PHAsset>?
    var showSelectMorePhotoButton: Bool
    
    public init(assets: PHFetchResult<PHAsset>? = nil, showSelectMorePhotoButton: Bool = false) {
        self.assets = assets
        self.showSelectMorePhotoButton = showSelectMorePhotoButton
    }
}

public protocol PhotoPickerPresentableListener: AnyObject {
    func action(_ action: PhotoPickerPresentableAction)
    var presentableState: Observable<PhotoPickerPresentableState> { get }
        
    func requestPhotoImage(asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void)
}

public final class PhotoPickerViewController: UIViewController {
    public weak var listener: PhotoPickerPresentableListener?
    
    private var disposeBag = DisposeBag()
    private var assets: PHFetchResult<PHAsset>?
    private var photoCellRegistration: UICollectionView.CellRegistration<AlbumPhotoCell, PHAsset>?
    
    private let photoPickerView = PhotoPickerView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.shared().register(self)
        
        self.isModalInPresentation = true
        self.photoPickerView.collectionView.dataSource = self
        
        cellRegister()
        
        bindAction()
        bindState()                
    }
    
    public override func loadView() {
        view = photoPickerView
    }
    
    private func cellRegister() {
        photoCellRegistration = UICollectionView.CellRegistration<AlbumPhotoCell, PHAsset> { [weak self] cell, _, asset in
            
            cell.assetIdentifier = asset.localIdentifier
            
            self?.listener?.requestPhotoImage(asset: asset, targetSize: .init(width: 250, height: 250), completion: { [weak cell] image in
                if let cell, cell.assetIdentifier == asset.localIdentifier {
                    cell.configure(with: image)
                }
            })
            
        }
    }
    
    private func bindAction() {
        listener?.action(.viewDidLoad)
        
        photoPickerView.xButton.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.xButtonDidTap)
            })
            .disposed(by: disposeBag)
        
        photoPickerView.selectMorePhotoButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.presentLimitedLibrarySelection()
            })
            .disposed(by: disposeBag)
        
        photoPickerView.moveToSettingButton.rx.tap
            .subscribe(onNext: { _ in
                if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingURL)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        
        listener?.presentableState
            .map(\.assets)
            .subscribe(onNext: { [weak self] result in
                self?.assets = result
                self?.photoPickerView.reloadCollectionView()
            })
            .disposed(by: disposeBag)
        
        listener?.presentableState
            .map(\.showSelectMorePhotoButton)
            .subscribe(onNext: { [weak self] show in
                
                self?.photoPickerView.setShowMorePhotoButtonVisibility(show)
            })
            .disposed(by: disposeBag)
        
    }
}

// MARK: - CollectionView DataSource
extension PhotoPickerViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellRegistration = photoCellRegistration {
            
            let item = assets?[indexPath.item]
            
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        } else {
            fatalError("CellProvider should return cell.")
        }
    }
}

// MARK: - Present the limited-library selection user interface/
extension PhotoPickerViewController {
    func presentLimitedLibrarySelection() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
}


// MARK: - PHPhotoLibraryChangeObserver
extension PhotoPickerViewController: PHPhotoLibraryChangeObserver {
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let old = assets else { return }
        
        DispatchQueue.main.sync {
            if let changes = changeInstance.changeDetails(for: old) {
                assets =  changes.fetchResultAfterChanges
                photoPickerView.collectionView.reloadData()
            }
        }
    }
}
