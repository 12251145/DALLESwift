//
//  DALLEGenerateView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import PinLayout
import UIKit

final public class DALLEGenerateView: UIView {
    private let generateButton = CapsuleButton("GENERATE")
    
    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(generateButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        generateButton.pin.hCenter().vCenter().width(90%).height(50)
    }
}
