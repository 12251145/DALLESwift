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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        collectionView.pin.all()
    }
}
