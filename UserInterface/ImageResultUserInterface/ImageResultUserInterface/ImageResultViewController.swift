//
//  ImageResultViewController.swift
//  ImageResultUserInterface
//
//  Created by Hoen on 2023/03/23.
//

import DesignSystem
import PinLayout
import RxCocoa
import RxSwift
import UIKit

public enum ImageResultPresentableAction {
    case viewDidLoad
}

public struct ImageResultPresentableState {
    var images: [UIImage]
    
    public init(images: [UIImage] = []) {
        self.images = images
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    func action(_ action: ImageResultPresentableAction)
    var presentableState: Observable<ImageResultPresentableState> { get }
}

public final class ImageResultViewController: UIViewController {
    public weak var listener: ImageResultPresentableListener?
    private var disposeBag = DisposeBag()
    
    private var imageResultView = ImageResultView()
    
    private var imageCellRegistration = UICollectionView.CellRegistration<GeneratedImageCell, UIImage> { cell, _, image in
        cell.configure(with: image)
    }
    
    private var images: [UIImage] = []
    
    public override func loadView() {
        self.view = imageResultView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.isModalInPresentation = true
        self.imageResultView.imageCollectionView.dataSource = self
        
        bindAction()
        bindState()
    }
    
    func bindAction() {
        listener?.action(.viewDidLoad)
    }
    
    func bindState() {
        listener?.presentableState
            .map(\.images)
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] images in
                self?.images = images
                self?.imageResultView.imageCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionView DataSource
extension ImageResultViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = images[indexPath.item]
        
        return collectionView.dequeueConfiguredReusableCell(
            using: imageCellRegistration,
            for: indexPath,
            item: item
        )
    }
}
