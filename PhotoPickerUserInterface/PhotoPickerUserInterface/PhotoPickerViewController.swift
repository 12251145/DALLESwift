//
//  PhotoPickerViewController.swift
//  PhotoPickerUserInterface
//
//  Created by Hoen on 2023/03/24.
//

import DesignSystem
import Photos
import RxRelay
import RxSwift
import UIKit

public enum PhotoPickerPresentableAction {
    case viewDidLoad
}

public struct PhotoPickerPresentableState {
    
    var assets: PHFetchResult<PHAsset>?
    
    public init(assets: PHFetchResult<PHAsset>? = nil) {
        self.assets = assets
    }
}

public protocol PhotoPickerPresentableListener: AnyObject {
    func action(_ action: PhotoPickerPresentableAction)
    var presentableState: Observable<PhotoPickerPresentableState> { get }
}

public final class PhotoPickerViewController: UIViewController {
    public weak var listener: PhotoPickerPresentableListener?
    
    private var disposeBag = DisposeBag()
    private var assets: PHFetchResult<PHAsset>?
    private var photoCellRegistration: UICollectionView.CellRegistration<AlbumPhotoCell, PHAsset>?
    
    private let photoPickerView = PhotoPickerView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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
        photoCellRegistration = UICollectionView.CellRegistration<AlbumPhotoCell, PHAsset> { cell, _, asset in
            
            cell.assetIdentifier = asset.localIdentifier
            
            Task { [cell] in
                try? await Task.sleep(nanoseconds: 1000000000)
                
                if cell.assetIdentifier == asset.localIdentifier {
                    print("Image configured! \(asset.localIdentifier)")
                    cell.configure(with: UIImage(systemName: "scribble.variable")!)
                } else {
                    print("이미 재사용되어버림!")
                }
            }
        }
    }
    
    private func bindAction() {
        listener?.action(.viewDidLoad)
    }
    
    private func bindState() {
        
        listener?.presentableState
            .map(\.assets)
            .subscribe(onNext: { [weak self] result in
                self?.assets = result
                self?.photoPickerView.reloadCollectionView()
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
