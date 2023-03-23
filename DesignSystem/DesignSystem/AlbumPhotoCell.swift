//
//  AlbumPhotoCell.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/23.
//

import PinLayout
import UIKit

public final class AlbumPhotoCell: UICollectionViewCell {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    private func layout() {
        imageView.pin.all()
    }
}
