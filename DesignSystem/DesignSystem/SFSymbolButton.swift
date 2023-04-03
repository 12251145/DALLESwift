//
//  SFSymbolButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/29.
//

import UIKit

public final class SFSymbolButton: UIButton {
    
    public init(symbolName: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        
        configure(symbolName, size, color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ symbolName: String, _ size: CGFloat, _ color: UIColor) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: symbolName)
        config.preferredSymbolConfigurationForImage = .init(pointSize: size)
        config.baseForegroundColor = color
        
        self.configuration = config
    }
}
