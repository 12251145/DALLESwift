//
//  GeneratedImageCell.swift
//  DesignSystem
//
//  Created by Hoen on 2023/04/04.
//

import PinLayout
import UIKit

public final class GeneratedImageCell: UICollectionViewCell {
    
    public override var isHighlighted: Bool {
        didSet {
            if oldValue == false && isHighlighted {
                animateScale(to: .init(scaleX: 0.95, y: 0.95), duration: 0.2)
            } else if oldValue == true && !isHighlighted {
                animateScale(to: .identity, duration: 0.2)
            }
        }
    }
    
    public var assetIdentifier: String?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray6
        
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

// MARK: - ScaleHighlightable
private extension GeneratedImageCell {
    func animateScale(to transform: CGAffineTransform, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.transform = transform
        }
    }
}
