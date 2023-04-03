//
//  CapsuleButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import UIKit

public class CapsuleButton: UIButton {
    
    public init(
        title: String,
        symbolName: String? = nil,
        backgroundColor: UIColor = .black,
        foregroundColor: UIColor = .white,
        titleSize: CGFloat = 18,
        symbolSize: CGFloat = 12,
        fontWeight: UIFont.Weight = .medium) {
            
            super.init(frame: .zero)
            configure(title, symbolName, backgroundColor, foregroundColor, titleSize, symbolSize, fontWeight)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(
        _ title: String,
        _ symbolName: String?,
        _ backgroundColor: UIColor,
        _ foregroundColor: UIColor,
        _ titleSize: CGFloat,
        _ symbolSize: CGFloat,
        _ fontWeight: UIFont.Weight) {
            
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = backgroundColor
            config.cornerStyle = .capsule
            
            if let symbolName {
                config.image = UIImage(systemName: symbolName)
                config.preferredSymbolConfigurationForImage = .init(pointSize: symbolSize)
                config.imagePadding = 5
            }
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: titleSize, weight: fontWeight),
                .foregroundColor: foregroundColor
            ]
            
            let nsStr = NSAttributedString(string: title, attributes: attrs)
            
            config.attributedTitle = .init(nsStr)
            
            self.configuration = config
        }
}
