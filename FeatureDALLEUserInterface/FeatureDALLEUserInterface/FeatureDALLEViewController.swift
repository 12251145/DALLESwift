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
    case generate
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
    
    public override func loadView() {
        self.view = DALLEGenerateView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
