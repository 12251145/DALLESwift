//
//  DALLEGenerateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import PinLayout
import UIKit

final public class DALLEGenerateView: UIView {
    
    private var scrollView = ScrollView()
    public private(set) var promptView = PromptView()
    public private(set) var generateButton = CapsuleButton("GENERATE")
    
    private var keyboardHeight: CGFloat = 0 {
        didSet {
            layout()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }        
    
    private func configureUI() {
        addSubview(scrollView)
        addSubview(generateButton)
        
        scrollView.append(promptView, 90%, 250)
    }
    
    private func layout() {
        if keyboardHeight == 0 {
            generateButton.pin.hCenter().bottom(pin.safeArea.bottom + 12).width(80%).height(50)
            scrollView.pin.above(of: generateButton).left().right().top(pin.safeArea.top)
            scrollView.updateHeight(promptView, 250)
            
        } else {
            generateButton.pin.hCenter().bottom(keyboardHeight + 16).width(80%).height(50)
            scrollView.pin.above(of: generateButton).left().right().top(pin.safeArea.top)
            scrollView.updateHeight(promptView, 200)
        }
        
    }
    
    public func adjustUIWithKeyboardHeight(_ height: CGFloat) {
        keyboardHeight = height
    }
}
