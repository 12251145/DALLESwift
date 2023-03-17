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
}

public struct FeatureDALLEPresentableState {
    var generateButtonEnabled: Bool
        
    public init(generateButtonEnabled: Bool) {
        self.generateButtonEnabled = generateButtonEnabled
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
        
        bindAction()
        bindState()
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
    }
    
    func bindState() {
        listener?.presentableState
            .map(\.generateButtonEnabled)
            .distinctUntilChanged()
            .bind(to: generateView.generateButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
