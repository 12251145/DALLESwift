//
//  ImageEditViewController.swift
//  ImageEditUserInterface
//
//  Created by Hoen on 2023/03/25.
//

import DesignSystem
import RxCocoa
import RxSwift
import UIKit

public enum ImageEditPresentableAction {
    case viewDidLoad
    case doneButtonDidTap
    case xButtonDidTap
}

public struct ImageEditPresentableState {
    public init() { }
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
        imageCropRotateView.image = UIImage(systemName: "pencil")
        
        bindAction()
    }
    
    func bindAction() {
        listener?.action(.viewDidLoad)
        
        imageCropRotateView.doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.doneButtonDidTap)
            })
            .disposed(by: disposeBag)
        
        imageCropRotateView.xButton.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.xButtonDidTap)
            })
            .disposed(by: disposeBag)
            
    }
}
