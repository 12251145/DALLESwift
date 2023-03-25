//
//  RectangleButton.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/25.
//

import PinLayout
import UIKit

public class RectangleButton: UIButton {
    
    private let contentInset: CGFloat = 20
    private var bottomLine: CALayer?
    
    public init(title: String,
         backgroundColor: UIColor = .black,
         foregroundColor: UIColor = .black,
         titleSize: CGFloat = 18,
         fontWeight: UIFont.Weight = .regular) {
        
        super.init(frame: .zero)
        configure(title, backgroundColor, foregroundColor, titleSize, fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    public func addBottomSeparator() {
        let line = generateSeparatorLine()
        self.layer.addSublayer(line)
        bottomLine = line
        setNeedsLayout()
    }
    
    private func layout() {
        bottomLine?.pin.bottom().left(contentInset).right(contentInset).height(1)
    }
    
    private func configure(
        _ title: String,
        _ backgroundColor: UIColor,
        _ foregroundColor: UIColor,
        _ titleSize: CGFloat,
        _ fontWeight: UIFont.Weight) {
            var config = UIButton.Configuration.plain()
            
            config.baseBackgroundColor = backgroundColor
            config.cornerStyle = .fixed
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: titleSize, weight: fontWeight),
                .foregroundColor: foregroundColor
            ]
            
            let nsStr = NSAttributedString(string: title, attributes: attrs)
            config.attributedTitle = .init(nsStr)
            self.contentHorizontalAlignment = .leading
            config.contentInsets = .init(top: 0, leading: contentInset, bottom: 0, trailing: contentInset)
            
            self.configuration = config
        }
    
    private func generateSeparatorLine() -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor.systemGray6.cgColor
        
        return layer
    }
}
