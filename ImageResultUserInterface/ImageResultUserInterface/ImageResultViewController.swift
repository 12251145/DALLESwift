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
    
    public override func loadView() {
        self.view = imageResultView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.isModalInPresentation = true
        
        bindAction()
        bindState()
    }
    
    func bindAction() {
        listener?.action(.viewDidLoad)
    }
    
    func bindState() {
        listener?.presentableState
            .map(\.images)
            .map { $0.first }
            .bind(to: imageResultView.imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
