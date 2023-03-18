//
//  ImageResultPresenter.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/18.
//

import FeatureDALLEUserInterface
import RIBs
import RxRelay
import RxSwift
import UIKit

public final class ImageResultPresenter: ImageResultPresentable, ImageResultViewControllable {
    
    public weak var listener: ImageResultPresentableListener? {
        didSet {
            listenerMapper = listener.map(ImageResultPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }
    
    public var uiviewController: UIViewController { viewController }
    private let viewController = ImageResultViewController()
    
    private var listenerMapper: ImageResultPresentableListenerMapper?
    
    init() {}
}

private final class ImageResultPresentableListenerMapper: FeatureDALLEUserInterface.ImageResultPresentableListener, ImageResultPresentableListener {
    
    var presentableState: Observable<FeatureDALLEUserInterface.ImageResultPresentableState>
    
    var action: PublishRelay<ImageResultPresentationAction>
    var state: Observable<ImageResultPresentationState>
    
    init(interactor: ImageResultPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: FeatureDALLEUserInterface.ImageResultPresentableAction) {
        self.action.accept(userAction.toMapper)
    }
}

