//
//  ImageResultInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import RIBs
import RxRelay
import RxSwift
import UIKit

public protocol ImageResultRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol ImageResultPresentable: Presentable {
    var listener: ImageResultPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol ImageResultListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ImageResultInteractor: PresentableInteractor<ImageResultPresentable>, ImageResultInteractable, ImageResultPresentableListener {

    weak var router: ImageResultRouting?
    weak var listener: ImageResultListener?
    
    let action = PublishRelay<ImageResultPresentationAction>()
    
    private let stateRelay: BehaviorRelay<ImageResultPresentationState>
    let state: Observable<ImageResultPresentationState>
    
    private let generateImageUseCase: RequestGenerateImageUseCase
    
    private var prompt: String?
    private var n: Int
    private var image: Data?
    private var masked: Bool

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        generateImageUseCase: RequestGenerateImageUseCase,
        presenter: ImageResultPresentable,
        prompt: String?,
        n: Int,
        image: Data?,
        masked: Bool
    ) {
        self.generateImageUseCase = generateImageUseCase
        self.stateRelay = .init(value: .init())
        self.state = stateRelay.asObservable()
        self.prompt = prompt
        self.n = n
        self.image = image
        self.masked = masked
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
                    let dummies = [UIImage](repeating: UIImage(), count: self.n)
                    var state = self.stateRelay.value
                    state.images = dummies
                    self.stateRelay.accept(state)
                    
                    Task {
                        do {
                            guard let image = self.image else { return }
                            
                            let images = try await self.generateImageUseCase.execute(
                                prompt: self.prompt,
                                n: self.n,
                                pngData: image,
                                masked: self.masked
                            )
                            
                            var newState = self.stateRelay.value
                            newState.images = images
                            self.stateRelay.accept(newState)
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
}
