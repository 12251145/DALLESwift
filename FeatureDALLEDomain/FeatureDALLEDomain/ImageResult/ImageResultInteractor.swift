//
//  ImageResultInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import RIBs
import RxRelay
import RxSwift

protocol ImageResultRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ImageResultPresentable: Presentable {
    var listener: ImageResultPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ImageResultListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ImageResultInteractor: PresentableInteractor<ImageResultPresentable>, ImageResultInteractable, ImageResultPresentableListener {

    weak var router: ImageResultRouting?
    weak var listener: ImageResultListener?
    
    let action = PublishRelay<ImageResultPresentationAction>()
    
    private let stateRelay: BehaviorRelay<ImageResultPresentationState>
    let state: Observable<ImageResultPresentationState>
    
    private let generateImageUseCase: RequestGenerateImageUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(generateImageUseCase: RequestGenerateImageUseCase, presenter: ImageResultPresentable) {
        self.generateImageUseCase = generateImageUseCase
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        bindAction()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func bindAction() {
        action
            .subscribe(onNext: { action in
                switch action {
                case .viewDidLoad:
                    Task {
                        let image = await self.generateImageUseCase.execute()
                        var newState = self.stateRelay.value
                        newState.image = image
                        self.stateRelay.accept(newState)
                    }
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
}
