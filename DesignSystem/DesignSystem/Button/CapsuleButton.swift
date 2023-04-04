//
//  CapsuleButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import UIKit

public class CapsuleButton: UIButton {
    
    public struct Config {
        var title: String?
        var symbolName: String?
        var backgroundColor: UIColor
        var foregroundColor: UIColor
        var titleSize: CGFloat
        var symbolSize: CGFloat
        var fontWeight: UIFont.Weight
        
        init(
            title: String? = nil,
            symbolName: String? = nil,
            backgroundColor: UIColor = .black,
            foregroundColor: UIColor = .white,
            titleSize: CGFloat = 18,
            symbolSize: CGFloat = 12,
            fontWeight: UIFont.Weight = .medium
        ) {
            self.title = title
            self.symbolName = symbolName
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.titleSize = titleSize
            self.symbolSize = symbolSize
            self.fontWeight = fontWeight
        }
    }
    
    public var config: Config {
        didSet {
            configure(with: config)
        }
    }
    
    public init(with capsuleConfig: Config) {
        self.config = capsuleConfig
        super.init(frame: .zero)
        
        configure(with: capsuleConfig)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with capsuleConfig: Config) {
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = capsuleConfig.backgroundColor
        config.cornerStyle = .capsule
        
        if let symbolName = capsuleConfig.symbolName {
            config.image = UIImage(systemName: symbolName)
            config.preferredSymbolConfigurationForImage = .init(pointSize: capsuleConfig.symbolSize)
            config.imagePadding = 5
        }
        
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: capsuleConfig.titleSize, weight: capsuleConfig.fontWeight),
            .foregroundColor: capsuleConfig.foregroundColor
        ]
        
        if let title = capsuleConfig.title {
            let nsStr = NSAttributedString(string: title, attributes: attrs)
            config.attributedTitle = .init(nsStr)
        }
        
        self.configuration = config
    }
}
