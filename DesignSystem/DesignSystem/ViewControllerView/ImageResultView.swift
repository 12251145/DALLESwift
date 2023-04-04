//
//  ImageResultView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/18.
//

import PinLayout
import UIKit

final public class ImageResultView: UIView {

    public private(set) var imageCollectionView = CenteredPagingCollectionView(width: 300, height: 300)
    
    public init() {
        super.init(frame: .zero)
        
        imageCollectionView.delaysContentTouches = false
        backgroundColor = .white        
        addSubview(imageCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
                
        imageCollectionView.pin.vCenter(-15%).left().right().height(300)
    }
}
