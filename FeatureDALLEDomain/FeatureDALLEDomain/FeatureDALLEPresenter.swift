//
//  FeatureDALLEPresenter.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import FeatureDALLEUserInterface
import RIBs
import RxRelay
import RxSwift
import UIKit

public final class FeatureDALLEPresenter: FeatureDALLEPresentable, FeatureDALLEViewControllable {
    
    public weak var listener: FeatureDALLEPresentableListener? {
        didSet {
            listenerMapper = listener.map(FeatureDALLEPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }
    
    public var uiviewController: UIViewController { viewController }
    private let viewController = FeatureDALLEViewController()
    
    private var listenerMapper: FeatureDALLEPresentableListenerMapper?
    
    init() {}
}

private final class FeatureDALLEPresentableListenerMapper: FeatureDALLEUserInterface.FeatureDALLEPresentableListener, FeatureDALLEPresentableListener {
    
    var presentableState: Observable<FeatureDALLEUserInterface.FeatureDALLEPresentableState>
    
    var action: PublishRelay<PresentationAction>
    var state: Observable<PresentationState>
    
    init(interactor: FeatureDALLEPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: FeatureDALLEUserInterface.FeatureDALLEPresentableAction) {
        self.action.accept(userAction.toMapper)
    }
}
