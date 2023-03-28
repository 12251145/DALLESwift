//
//  ImageEditViewController.swift
//  ImageEditUserInterface
//
//  Created by Hoen on 2023/03/25.
//

import DesignSystem
import RxCocoa
import RxRelay
import RxSwift
import UIKit

public enum ImageEditPresentableAction {
    case viewDidLoad
    case doneButtonDidTap(rect: CGRect)
    case xButtonDidTap
}

public struct ImageEditPresentableState {
    var image: UIImage?
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol ImageEditPresentableListener: AnyObject {
    func action(_ action: ImageEditPresentableAction)
    var presentableState: Observable<ImageEditPresentableState> { get }
}

public final class ImageEditViewController: UIViewController {
    public weak var listener: ImageEditPresentableListener?
    private var disposeBag = DisposeBag()
    
    private let imageCropRotateView = ImageCropRotateView(cropSize: .init(width: 320, height: 320))
    
    public override func loadView() {
        view = imageCropRotateView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindAction()
        bindState()
    }
    
    func bindAction() {
        listener?.action(.viewDidLoad)
        
        imageCropRotateView.doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in                
                if let croppedRect = self?.imageCropRotateView.cropRect() {
                    self?.listener?.action(.doneButtonDidTap(rect: croppedRect))
                }
            })
            .disposed(by: disposeBag)
        
        imageCropRotateView.xButton.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.xButtonDidTap)
            })
            .disposed(by: disposeBag)
            
    }
    
    func bindState() {
        listener?.presentableState
            .compactMap(\.image)
            .subscribe(onNext: { [weak self] image in
                self?.imageCropRotateView.image = image
            })
            .disposed(by: disposeBag)
    }
}
