//
//  ImageResultViewController.swift
//  ImageResultUserInterface
//
//  Created by Hoen on 2023/03/17.
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
    var image: UIImage?
    
    public init(image: UIImage? = nil) {
        self.image = image
    }
}

public protocol ImageResultPresentableListener: AnyObject {
    func action(_ action: ImageResultPresentableAction)
    var presentableState: Observable<ImageResultPresentableState> { get }
}

public final class ImageResultViewController: UIViewController {
    
    public weak var listener: ImageResultPresentableListener?
    private var disposeBag = DisposeBag()
    
    private let imageResultView = ImageResultView()
    
    public override func loadView() {
        self.view = imageResultView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
