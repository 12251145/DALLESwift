//
//  ImageEditViewController.swift
//  ImageEditUserInterface
//
//  Created by Hoen on 2023/03/25.
//

import DesignSystem
import RxSwift
import UIKit

public enum ImageEditPresentableAction {
    case viewDidLoad
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
    
    private let imageCropRotateView = ImageCropRotateView()
    
    public override func loadView() {
        view = imageCropRotateView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        imageCropRotateView.image = UIImage(named: "testImage")
    }
}
