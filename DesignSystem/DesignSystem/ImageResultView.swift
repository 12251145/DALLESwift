//
//  ImageResultView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/18.
//

import PinLayout
import UIKit

final public class ImageResultView: UIView {
    public private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.pin.hCenter().vCenter(-5%).width(90%).height(500)
    }
}
