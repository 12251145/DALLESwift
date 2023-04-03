//
//  FeatureDALLEViewController.swift
//  FeatureDALLEUserInterface
//
//  Created by Hoen on 2023/03/16.
//

import DesignSystem
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
}

public struct FeatureDALLEPresentableState {
    var image: UIImage?
    var mask: UIImage?
    var prompt: String?
    var generateButtonEnabled: Bool
    var keyBoardHeight: CGFloat
    var imageProcessing: Bool
    var pngData: Data?
        
    public init(
        image: UIImage? = nil,
        mask: UIImage? = nil,
        prompt: String? = nil,
        generateButtonEnabled: Bool = false,
        keyBoardHeight: CGFloat = 0,
        imageProcessing: Bool = false,
        pngData: Data? = nil) {
        
            self.image = image
            self.mask = mask
            self.prompt = prompt
            self.generateButtonEnabled = generateButtonEnabled
            self.keyBoardHeight = keyBoardHeight
            self.imageProcessing = imageProcessing
            self.pngData = pngData
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
        
        listener?.presentableState
            .asDriver(onErrorJustReturn: .init())
            .map(\.mask)
            .map({ $0 != nil })
            .drive(onNext: { [weak self] maskOn in
                self?.generateView.maskOn(maskOn)
            })
            .disposed(by: disposeBag)
        
    }
}
