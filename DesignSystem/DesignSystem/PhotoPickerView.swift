//
//  PhotoPickerView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/23.
//

import PinLayout
import UIKit

public final class PhotoPickerView: UIView {
    
    public let collectionView = GridView(
        itemSize: .init(
            widthDimension: .fractionalWidth(1 / 3),
            heightDimension: .fractionalWidth(1 / 3)
        ),
        direction: .vertical
    )
    
    public init() {
        super.init(frame: .zero)
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
        
        layout()
    }
    
    private func layout() {
        collectionView.pin.all()
    }
}
