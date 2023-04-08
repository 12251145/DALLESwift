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
    case variationButtonDidTap(image: UIImage)
    case xButtonDidTap
}

public struct ImageResultPresentableState {
    var images: [UIImage]
    var variationButtonEnabled: Bool
    
    public init(images: [UIImage] = [], variationButtonEnabled: Bool = false) {
        self.images = images
        self.variationButtonEnabled = variationButtonEnabled
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
        
        imageResultView.variationButton.rx.tap
            .subscribe(onNext: { [weak self] _ in

                guard let isEmpty = self?.images.isEmpty,
                      !isEmpty,
                      let collectionViewCenter = self?.imageResultView.imageCollectionView.center,
                      let cell = self?.view.hitTest(collectionViewCenter, with: .none) as? GeneratedImageCell,
                      let index = self?.imageResultView.imageCollectionView.indexPath(for: cell)?.item,
                      let image = self?.images[index] else { return }
                
                self?.listener?.action(.variationButtonDidTap(image: image))
            })
            .disposed(by: disposeBag)
        
        imageResultView.xButton.button.rx.tap
            .subscribe { [weak self] _ in
                self?.listener?.action(.xButtonDidTap)
            }
            .disposed(by: disposeBag)
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
        
        listener?.presentableState
            .map(\.variationButtonEnabled)
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isEnabled in                
                self?.imageResultView.variationButton.isEnabled = isEnabled
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
