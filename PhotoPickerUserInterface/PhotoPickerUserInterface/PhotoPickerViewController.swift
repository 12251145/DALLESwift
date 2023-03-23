//
//  PhotoPickerViewController.swift
//  PhotoPickerUserInterface
//
//  Created by Hoen on 2023/03/23.
//

import DesignSystem
import RxSwift
import UIKit

public enum PhotoPickerPresentableAction {
    case viewDidLoad
}

public struct PhotoPickerPresentableState {
    public init() { }
}

public protocol PhotoPickerPresentableListener: AnyObject {
    func action(_ action: PhotoPickerPresentableAction)
    var presentableState: Observable<PhotoPickerPresentableState> { get }
}

public final class PhotoPickerViewController: UIViewController {
    public weak var listener: PhotoPickerPresentableListener?
    
    private var photoCellRegistration: UICollectionView.CellRegistration<AlbumPhotoCell, UIImage>?
    
    private let photoPickerView = PhotoPickerView()
    private var dataSource: DataSource?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        cellRegister()
        setDataSource()
    }
    
    public override func loadView() {
        view = photoPickerView
    }
    
    private func cellRegister() {
        photoCellRegistration = UICollectionView.CellRegistration<AlbumPhotoCell, UIImage> { cell, _, image in
            cell.configure(with: image)
        }
    }
}

// MARK: - CollectionView DataSource
private extension PhotoPickerViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<String, String>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<String, String>
    
    func setDataSource() {
        dataSource = DataSource(
            collectionView: photoPickerView.collectionView,
            cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
                
                if let cellRegistration = self?.photoCellRegistration {
                    return collectionView.dequeueConfiguredReusableCell(
                        using: cellRegistration,
                        for: indexPath,
                        item: UIImage(systemName: "pencil")
                    )
                } else {
                    fatalError("CellProvider should return cell.")
                }
            }
        )
    }
}
