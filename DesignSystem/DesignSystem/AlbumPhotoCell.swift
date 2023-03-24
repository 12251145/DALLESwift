//
//  AlbumPhotoCell.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/23.
//

import PinLayout
import UIKit

public final class AlbumPhotoCell: UICollectionViewCell {
    public var assetIdentifier: String?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    public func configure(with image: UIImage?) {
        imageView.image = image
    }
    
    private func layout() {
        imageView.pin.all()
    }
}
