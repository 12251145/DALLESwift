//
//  FootLightView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/22.
//

import PinLayout
import UIKit

public final class FootLightView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    init(color: UIColor = .white, startYPoint: CGFloat = 0.5, height: CGFloat = 12) {
        super.init(frame: .init(x: 0, y: 0, width: 0, height: height))
        
        setGradient(color, startYPoint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.pin.all()
    }
    
    func setGradient(_ color: UIColor, _ startYPoint: CGFloat) {
        
        gradientLayer.colors = [color.cgColor, color.withAlphaComponent(0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = .init(x: 0, y: startYPoint)
        gradientLayer.endPoint = .init(x: 0, y: 0.0)
        
        layer.addSublayer(gradientLayer)
    }
}
