//
//  ImageResultInteractor.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import BaseDependencyDomain
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
    func detachImageResult()
}

final class ImageResultInteractor: PresentableInteractor<ImageResultPresentable>, ImageResultInteractable, ImageResultPresentableListener {

    weak var router: ImageResultRouting?
    weak var listener: ImageResultListener?
    
    let action = PublishRelay<ImageResultPresentationAction>()
    
    private let stateRelay: BehaviorRelay<ImageResultPresentationState>
    let state: Observable<ImageResultPresentationState>
    
    private let downSamplingImageDataUseCase: DownSamplingImageDataUseCase
    private let generateImageUseCase: RequestGenerateImageUseCase
    
    private var requestTask: Task<Void, Never>?
    private var variationTask: Task<Void, Never>?
    
    private var prompt: String?
    private var n: Int
    private var image: Data?
    private var masked: Bool

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        generateImageUseCase: RequestGenerateImageUseCase,
        downSamplingImageDataUseCase: DownSamplingImageDataUseCase,
        presenter: ImageResultPresentable,
        prompt: String?,
        n: Int,
        image: Data?,
        masked: Bool
    ) {
        self.generateImageUseCase = generateImageUseCase
        self.downSamplingImageDataUseCase = downSamplingImageDataUseCase
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
               
        requestTask?.cancel()
        
    }
    
    func bindAction() {
        action
            .subscribe(onNext: { [weak self] action in
                switch action {
                case .viewDidLoad:
                    
                    self?.sendDummyState()
                    self?.generateRequestTask()
                    
                case .variationButtonDidTap(let image):
                    
                    self?.sendDummyState()
                    if let pngData = self?.resizedDownSampledData(image: image) {
                        self?.variationRequestTask(pngData)
                    }
                    
                case .xButtonDidTap:
                    self?.listener?.detachImageResult()
                }
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func sendDummyState() {
        let dummies = [UIImage](repeating: UIImage(), count: n)
        var state = stateRelay.value
        state.images = dummies
        state.variationButtonEnabled = false
        stateRelay.accept(state)
    }
    
    private func generateRequestTask() {
        requestTask = Task {
            do {
                guard let image = image else { return }
                
                let images = try await generateImageUseCase.execute(
                    prompt: prompt,
                    n: n,
                    pngData: image,
                    masked: masked
                )
                
                var newState = stateRelay.value
                newState.images = images
                newState.variationButtonEnabled = true
                stateRelay.accept(newState)
            } catch {
                print(error)
            }
        }
    }
    
    private func variationRequestTask(_ pngData: Data) {
        variationTask = Task {
            do {

                let images = try await generateImageUseCase.execute(
                    prompt: nil,
                    n: n,
                    pngData: pngData,
                    masked: false
                )
                
                var newState = stateRelay.value
                newState.images = images
                newState.variationButtonEnabled = true
                stateRelay.accept(newState)
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Private functions
private extension ImageResultInteractor {
    func isImageSquare(_ image: UIImage?) -> Bool {
        guard let image else { return false }
        
        return image.size.width == image.size.height
    }
    
    func resizedDownSampledData(image: UIImage) -> Data? {
        
        guard let imageData = image.pngData() else { return nil }

        var result = downSamplingImageDataUseCase.execute(data: imageData, originImage: image, maxMB: 4)
        
        var downSampledImage = result?.image
        
        if !isImageSquare(downSampledImage) {
            if let width = downSampledImage?.size.width {
                
                downSampledImage = downSampledImage?.resize(to: .init(width: width, height: width))
                
                if let downSampledImage, let correctData = downSampledImage.pngData() {
                    result = downSamplingImageDataUseCase.execute(data: correctData, originImage: downSampledImage, maxMB: 4)
                }
            }
        }
        
        return result?.data
    }
}
