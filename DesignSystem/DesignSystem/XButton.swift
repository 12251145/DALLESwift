//
//  XButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/24.
//

import PinLayout
import UIKit

public class XButton: UIView {

    private var xColor: UIColor
    private var buttonColor: UIColor?
    private var visualEffectView: UIVisualEffectView?
    public let button = UIButton()
    
    public init(xSize: CGFloat, xColor: UIColor, effectStyle: UIBlurEffect.Style) {
        self.xColor = xColor
        super.init(frame: .zero)
                
        let effect = UIBlurEffect(style: effectStyle)
        self.visualEffectView = .init(effect: effect)
        
        configure(xSize)
    }
    
    public init(xSize: CGFloat, xColor: UIColor, backgroundColor: UIColor) {
        self.xColor = xColor
        super.init(frame: .zero)
        buttonColor = backgroundColor
        
        configure(xSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func configure(_ xSize: CGFloat) {
        
        self.clipsToBounds = true
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.preferredSymbolConfigurationForImage = .init(pointSize: xSize, weight: .semibold)
        config.baseForegroundColor = xColor

        if let visualEffectView {
            addSubview(visualEffectView)
        }
        
        if let buttonColor {
            backgroundColor = buttonColor
        }
        
        button.configuration = config
        
        addSubview(button)
    }
    
    private func layout() {
        if let visualEffectView {
            visualEffectView.pin.all()
        }
        button.pin.all()
    }
}
