//
//  FeatureDALLEViewController.swift
//  FeatureDALLEUserInterface
//
//  Created by Hoen on 2023/03/16.
//

import DesignSystem
import KImageEraser
import PinLayout
import RxCocoa
import RxSwift
import UIKit

public enum FeatureDALLEPresentableAction {
    case promtInput(string: String?)
    case generateButtonTap
    case imageButtonTap
    case imageXButtonTap
    case editMaskButtonTap
    case nChanged(n: Int)
    case imageEraseDone(image: UIImage)
}

public struct FeatureDALLEPresentableState {
    var image: UIImage?
    var masked: Bool
    var prompt: String?
    var generateButtonEnabled: Bool
    var keyBoardHeight: CGFloat
    var imageProcessing: Bool
    var pngData: Data?
    var maskPngData: Data?
    var n: Int
    
    public init(
        image: UIImage? = nil,
        masked: Bool = false,
        prompt: String? = nil,
        generateButtonEnabled: Bool = false,
        keyBoardHeight: CGFloat = 0,
        imageProcessing: Bool = false,
        pngData: Data? = nil,
        n: Int = 1
    ) {
        
        self.image = image
        self.masked = masked
        self.prompt = prompt
        self.generateButtonEnabled = generateButtonEnabled
        self.keyBoardHeight = keyBoardHeight
        self.imageProcessing = imageProcessing
        self.pngData = pngData
        self.n = n
    }
}

public protocol FeatureDALLEPresentableListener: AnyObject {
    func action(_ action: FeatureDALLEPresentableAction)
    var presentableState: Observable<FeatureDALLEPresentableState> { get }
}

public final class FeatureDALLEViewController: UIViewController {
    
    public weak var listener: FeatureDALLEPresentableListener?
    private var disposeBag = DisposeBag()
    
    private let generateView = DALLEGenerateView()
    
    public override func loadView() {
        self.view = generateView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = NavigationTitleLabel(title: "DALL ・ E")
        self.navigationItem.titleView = titleLabel
        
        bindAction()
        bindState()
        setupHideKeyboardOnTap()
    }
    
    public func presentImageEraser(with image: UIImage) {
        let imageEraser = KImageEraserViewController(image: image)
        imageEraser.delegate = self
        imageEraser.modalPresentationStyle = .fullScreen
        
        self.present(imageEraser, animated: true)
    }
    
    func bindAction() {
        generateView.promptView.promptTextView.rx.text
            .subscribe(onNext: { [weak self] text in
                self?.listener?.action(.promtInput(string: text))
            })
            .disposed(by: disposeBag)
        
        generateView.generateButton.rx.tap
            .subscribe(onNext: { [weak self] _ in                
                self?.listener?.action(.generateButtonTap)
            })
            .disposed(by: disposeBag)
        
        generateView.showPhotoPickerButton.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.imageButtonTap)
            })
            .disposed(by: disposeBag)
        
        generateView.showPhotoPickerButton.editMaskButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.editMaskButtonTap)
            })
            .disposed(by: disposeBag)
        
        generateView.showPhotoPickerButton.xButton.button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.action(.imageXButtonTap)
            })
            .disposed(by: disposeBag)
        
        generateView.nStepper.stepper.rx.value
            .subscribe { value in
                self.listener?.action(.nChanged(n: Int(value)))
            }
            .disposed(by: disposeBag)
    }
    
    func bindState() {
        listener?.presentableState
            .map(\.generateButtonEnabled)
            .distinctUntilChanged()
            .bind(to: generateView.generateButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        listener?.presentableState
            .map(\.keyBoardHeight)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] height in
                self?.generateView.adjustUIWithKeyboardHeight(height)
            })
            .disposed(by: disposeBag)
        
        listener?.presentableState
            .asDriver(onErrorJustReturn: .init())
            .map(\.image)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] image in                
                self?.generateView.setImage(image)
            })
            .disposed(by: disposeBag)
        
        listener?.presentableState
            .asDriver(onErrorJustReturn: .init())
            .map(\.imageProcessing)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] isProcessing in
                self?.generateView.setProcessing(isProcessing)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ImageEraserDelegate
extension FeatureDALLEViewController: KImageEraserViewControllerDelegate {
    public func imageEraserViewControllerDoneImageErase(_ viewController: KImageEraser.KImageEraserViewController, image: UIImage) {
        listener?.action(.imageEraseDone(image: image))
        viewController.dismiss(animated: true)
    }
    
    public func imageEraserViewControllerCloseButtonDidTap(_ viewController: KImageEraser.KImageEraserViewController) {
        viewController.dismiss(animated: true)
    }
}
