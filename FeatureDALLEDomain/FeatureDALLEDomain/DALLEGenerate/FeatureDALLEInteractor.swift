//
//  FeatureDALLEInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import RIBs
import RxKeyboard
import RxRelay
import RxSwift
import Util

public protocol FeatureDALLERouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToImageResult()
}

public protocol FeatureDALLEPresentable: Presentable {
    var listener: FeatureDALLEPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol FeatureDALLEListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FeatureDALLEInteractor: PresentableInteractor<FeatureDALLEPresentable>, FeatureDALLEInteractable, FeatureDALLEPresentableListener {
    
    let action = PublishRelay<PresentationAction>()
    
    private let stateRelay: BehaviorRelay<PresentationState>
    let state: Observable<PresentationState>
    
    weak var router: FeatureDALLERouting?
    weak var listener: FeatureDALLEListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FeatureDALLEPresentable) {
        self.stateRelay = .init(value: .init(generateButtonEnabled: false, keyBoardHeight: 0))
        self.state = stateRelay.asObservable()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
            
        bindAction()
        observeKeyboard()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func bindAction() {
        action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .promtInput(let text):
                    
                    let isEnabled = text.notNilNotEmpty()
                    
                    if var newState = self?.stateRelay.value {
                        newState.generateButtonEnabled = isEnabled
                        self?.stateRelay.accept(newState)
                    }
                    
                case .generateButtonTap:
                    self?.router?.routeToImageResult()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func observeKeyboard() {
        RxKeyboard.instance.visibleHeight            
            .drive(onNext: { [weak self] height in
                if var newState = self?.stateRelay.value {
                    newState.keyBoardHeight = height
                    self?.stateRelay.accept(newState)
                }
            })
            .disposeOnDeactivate(interactor: self)
            
    }
    
    func stringIsNotNilAndEmpty(_ string: String?) -> Bool {
        if let string {
            return !string.isEmpty
        } else {
            return false
        }
    }
}
