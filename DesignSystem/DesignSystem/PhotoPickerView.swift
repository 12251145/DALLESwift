//
//  PhotoPickerView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/23.
//

import PinLayout
import UIKit

public final class PhotoPickerView: UIView {
    
    public let xButton = XButton(xSize: 15, effectStyle: .systemUltraThinMaterial)
    public let collectionView = GridView(
        itemSize: .init(
            widthDimension: .fractionalWidth(1 / 3),
            heightDimension: .fractionalWidth(1 / 3)
        ),
        direction: .vertical
    )
    public let selectMorePhotoButton = RectangleButton(title: "더 많은 사진 선택", titleSize: 16)
    public let moveToSettingButton = RectangleButton(title: "권한 설정으로 이동", titleSize: 16)
    
    private var collectionViewBottomView: UIView
    
    public init() {
        self.collectionViewBottomView = selectMorePhotoButton
        super.init(frame: .zero)
        
        collectionView.delaysContentTouches = false
        selectMorePhotoButton.addBottomSeparator()
        moveToSettingButton.addBottomSeparator()
        addSubview(collectionView)
        addSubview(selectMorePhotoButton)
        addSubview(moveToSettingButton)
        addSubview(xButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
        
        layout()
    }        
    
    public func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    private func layout() {
        moveToSettingButton.pin.left().right().bottom(pin.safeArea.bottom + 10).height(50)
        selectMorePhotoButton.pin.left().right().above(of: moveToSettingButton).height(50)
        collectionView.pin.above(of: collectionViewBottomView).top().left().right()
        xButton.pin.top(pin.safeArea.top + 15).right(pin.safeArea.right + 15).width(40).height(40)
        xButton.layer.cornerRadius = xButton.bounds.size.height / 2
    }
    
    public func setShowMorePhotoButtonVisibility(_ show: Bool) {
        if show {
            selectMorePhotoButton.isHidden = false
            collectionViewBottomView = selectMorePhotoButton
        } else {
            selectMorePhotoButton.isHidden = true
            collectionViewBottomView = moveToSettingButton
        }
        
        setNeedsLayout()
    }
}
