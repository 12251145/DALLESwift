//
//  XButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/24.
//

import PinLayout
import UIKit

public class XButton: UIView {
    
    private let visualEffectView: UIVisualEffectView
    private let button = UIButton()
    
    public init(xSize: CGFloat, effectStyle: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: effectStyle)
        self.visualEffectView = .init(effect: effect)
        super.init(frame: .zero)
            
        self.clipsToBounds = true
        
        addSubview(visualEffectView)
        addSubview(button)
                
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
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.preferredSymbolConfigurationForImage = .init(pointSize: 12, weight: .semibold)
        config.baseForegroundColor = .black
        
        button.configuration = config
    }
    
    private func layout() {
        visualEffectView.pin.all()
        button.pin.all()
    }
}
