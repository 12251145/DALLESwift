//
//  DALLEGenerateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import PinLayout
import UIKit

final public class DALLEGenerateView: UIView {
    
    public private(set) var promptView = PromptView()
    public private(set) var generateButton = CapsuleButton("GENERATE")
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(generateButton)
        addSubview(promptView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        promptView.pin.hCenter().top(pin.safeArea.top + 20).width(90%).height(250)
        generateButton.pin.hCenter().bottom(pin.safeArea.bottom + 12).width(80%).height(50)
    }
}
