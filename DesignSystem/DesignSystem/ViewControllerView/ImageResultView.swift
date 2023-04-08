//
//  ImageResultView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/18.
//

import PinLayout
import UIKit

final public class ImageResultView: UIView {

    public private(set) var imageCollectionView = CenteredPagingCollectionView(width: 320, height: 320)
    public private(set) var variationButton = CapsuleButton(with: .init(title: "VARIATION"))
    public private(set) var xButton = XButton(xSize: 15, xColor: .black, backgroundColor: .clear)
    
    public init() {
        super.init(frame: .zero)
        
        imageCollectionView.delaysContentTouches = false
        backgroundColor = .white        
        addSubview(imageCollectionView)
        addSubview(variationButton)
        addSubview(xButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
                
        layout()
    }
    
    private func layout() {
        imageCollectionView.pin.vCenter(-15%).left().right().height(320)
        variationButton.pin.hCenter().bottom(pin.safeArea.bottom + 12).width(80%).height(50)
        xButton.pin.top(pin.safeArea.top + 15).right(pin.safeArea.right + 15).width(40).height(40)
    }
}
