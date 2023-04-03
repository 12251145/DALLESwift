//
//  EditMaskViewController.swift
//  EditMaskUserInterface
//
//  Created by Hoen on 2023/04/03.
//

import RxSwift
import UIKit

public enum EditMaskPresentableAction {
    case viewDidLoad
}

public struct EditMaskPresentableState {
    public init() { }
}

public protocol EditMaskPresentableListener: AnyObject {
    func action(_ action: EditMaskPresentableAction)
    var presentableState: Observable<EditMaskPresentableState> { get }
}

public final class EditMaskViewController: UIViewController {
    public weak var listener: EditMaskPresentableListener?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
