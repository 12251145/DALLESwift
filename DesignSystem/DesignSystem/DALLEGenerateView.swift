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
        
        scrollView.pin.all()
        generateButton.pin.hCenter().bottom(pin.safeArea.bottom + 12).width(80%).height(50)
    }        
    
    private func configureUI() {
        addSubview(scrollView)
        addSubview(generateButton)
        
        scrollView.append(promptView, 90%, 250)
    }
}
