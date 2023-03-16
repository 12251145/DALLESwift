//
//  FeatureDALLEInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/16.
//

import ReactorKit
import RIBs
import RxSwift

protocol FeatureDALLERouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FeatureDALLEPresentable: Presentable {
    var listener: FeatureDALLEPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FeatureDALLEListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FeatureDALLEInteractor: PresentableInteractor<FeatureDALLEPresentable>, FeatureDALLEInteractable, FeatureDALLEPresentableListener, Reactor {
    
    enum Mutation {
        case generateButtonEnable(Bool)
    }
    
    typealias Action = PresentationAction
    typealias State = PresentationState
    
    var initialState: State = .init(generateButtonEnabled: false)

    weak var router: FeatureDALLERouting?
    weak var listener: FeatureDALLEListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FeatureDALLEPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func mutate(action: PresentationAction) -> Observable<Mutation> {
        switch action {
        case .promtInput(let string):
            let isEnabled = stringIsNotNilAndEmpty(string)
            return .just(.generateButtonEnable(isEnabled))
        }
    }
    
    func reduce(state: PresentationState, mutation: Mutation) -> PresentationState {
        var newState = state
        
        switch mutation {
        case .generateButtonEnable(let isEnabled):
            newState.generateButtonEnabled = isEnabled
        }
        
        return newState
    }
    
    func stringIsNotNilAndEmpty(_ string: String?) -> Bool {
        if let string {
            return !string.isEmpty
        } else {
            return false
        }
    }
}
