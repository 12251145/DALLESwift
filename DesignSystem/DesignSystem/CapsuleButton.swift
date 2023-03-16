//
//  CapsuleButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import UIKit

public class CapsuleButton: UIButton {
    
    init(_ title: String,
         _ backgroundColor: UIColor = .black,
         _ foregroundColor: UIColor = .white,
         _ titleSize: CGFloat = 18,
         _ fontWeight: UIFont.Weight = .medium) {
        
        super.init(frame: .zero)
        configure(title, backgroundColor, foregroundColor, titleSize, fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(
        _ title: String,
        _ backgroundColor: UIColor,
        _ foregroundColor: UIColor,
        _ titleSize: CGFloat,
        _ fontWeight: UIFont.Weight) {
            
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = backgroundColor
            config.cornerStyle = .capsule
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: titleSize, weight: fontWeight),
                .foregroundColor: foregroundColor
            ]
            
            let nsStr = NSAttributedString(string: title, attributes: attrs)
            
            config.attributedTitle = .init(nsStr)
            
            self.configuration = config
        }
}
