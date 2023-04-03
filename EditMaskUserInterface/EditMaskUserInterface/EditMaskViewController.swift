//
//  EditMaskViewController.swift
//  EditMaskUserInterface
//
//  Created by Hoen on 2023/04/03.
//

import DesignSystem
import RxCocoa
import RxRelay
import RxSwift
import UIKit

public enum EditMaskPresentableAction {
    case viewDidLoad
}

public struct EditMaskPresentableState {
    var image: UIImage?
    public init(image: UIImage?) {
        self.image = image
    }
}

public protocol EditMaskPresentableListener: AnyObject {
    func action(_ action: EditMaskPresentableAction)
    var presentableState: Observable<EditMaskPresentableState> { get }
}

public final class EditMaskViewController: UIViewController {
    public weak var listener: EditMaskPresentableListener?
    private var disposeBag = DisposeBag()
    
    let drawMaskView = DrawMaskView()
    
    public override func loadView() {
        view = drawMaskView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindAction()
        bindState()              
    }
    
    private func bindAction() {
        listener?.action(.viewDidLoad)
    }
    
    private func bindState() {
        listener?.presentableState
            .map(\.image)
            .asDriver(onErrorJustReturn: nil)
            .compactMap({ $0 })
            .drive(onNext: { [weak self] image in
                self?.drawMaskView.originImage = image
            })
            .disposed(by: disposeBag)
            
    }
}
