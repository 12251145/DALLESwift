//
//  DottedBorderButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/22.
//

import UIKit

public final class DottedBorderButton: UIButton {
    private let borderLayer = CAShapeLayer()
    
    public init(title: String, image: UIImage? = nil) {
        super.init(frame: .zero)
        
        configure(title, image)
        setBorderLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateBorderPath()
    }
    
    private func configure(_ title: String, _ image: UIImage? = nil) {
                
        layer.cornerCurve = .continuous
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray6
        config.cornerStyle = .medium
        config.image = image
        config.title = title
        config.baseForegroundColor = .darkGray
        config.imagePadding = 10
        
        self.configuration = config
    }
    
    private func setBorderLayer() {
        
        updateBorderPath()
        
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 2.0
        borderLayer.lineCap = .round
        
        borderLayer.lineDashPattern = [7, 10]
        
        layer.addSublayer(borderLayer)
    }
    
    private func updateBorderPath() {

        let borderPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.height * 0.2)
        borderLayer.path = borderPath.cgPath

    }
}
