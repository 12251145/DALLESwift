//
//  PromptView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import UIKit

public class PromptView: UIView {
        
    private let backgroundShadowView = UIView()
    private let promptTextView = UITextView(frame: .zero, textContainer: nil)        
    
    public init(
        _ fontSize: CGFloat = 20,
        _ fontWeight: UIFont.Weight = .semibold
    ) {
        
        super.init(frame: .zero)
        
        addSubview(backgroundShadowView)
        addSubview(promptTextView)
        
        configure(fontSize, fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        backgroundShadowView.pin.all()
        promptTextView.pin.all()
    }
    
    private func configure(
        _ fontSize: CGFloat,
        _ fontWeight: UIFont.Weight
    ) {
        
        backgroundShadowView.addShadow(opacity: 0.1, offset: .init(width: 0, height: 3), radius: 10)
        backgroundShadowView.layer.masksToBounds = false
        backgroundShadowView.backgroundColor = .white
        
        backgroundShadowView.layer.cornerCurve = .continuous
        backgroundShadowView.layer.cornerRadius = 20
        promptTextView.layer.cornerCurve = .continuous
        promptTextView.layer.cornerRadius = 20
        
        promptTextView.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        promptTextView.backgroundColor = .white
        promptTextView.textContainerInset = .init(top: 18, left: 18, bottom: 18, right: 18)
        promptTextView.showsVerticalScrollIndicator = false
        promptTextView.showsHorizontalScrollIndicator = false
    }
}
