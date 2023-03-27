//
//  ImageEditPresenter.swift
//  ImageEditDomain
//
//  Created by Hoen on 2023/03/27.
//

import ImageEditUserInterface
import RIBs
import RxRelay
import RxSwift
import UIKit

public final class ImageEditPresenter: ImageEditPresentable, ImageEditViewControllable {
    
    public weak var listener: ImageEditPresentableListener? {
        didSet {
            listenerMapper = listener.map(ImageEditPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }
    
    public var uiviewController: UIViewController { viewController }
    private let viewController = ImageEditViewController()
    
    private var listenerMapper: ImageEditPresentableListenerMapper?
    
    init() {}
}

private final class ImageEditPresentableListenerMapper: ImageEditUserInterface.ImageEditPresentableListener, ImageEditPresentableListener {
    
    var presentableState: Observable<ImageEditUserInterface.ImageEditPresentableState>
    
    var action: PublishRelay<ImageEditPresentationAction>
    var state: Observable<ImageEditPresentationState>
    
    init(interactor: ImageEditPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.presentableState = interactor.state.map(\.toMapper)
    }
    
    func action(_ userAction: ImageEditUserInterface.ImageEditPresentableAction) {
        self.action.accept(userAction.toMapper)
    }
}
