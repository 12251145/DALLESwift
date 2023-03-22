//
//  NStepper.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/22.
//

import PinLayout
import UIKit
import Util

public final class NStepper: UIView {
    private let icon = UIImageView()
    private let nLabel = UILabel()
    public private(set) var stepper = UIStepper()

    public init(low: Double, high: Double) {

        super.init(frame: .zero)
        
        let minimum = min(low, high)
        let maximum = max(low, high)
        
        addSubview(icon)
        addSubview(nLabel)
        addSubview(stepper)
        
        configure(minimum: minimum, maximum: maximum)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.pin.vCenter().left().width(25).height(25).maxWidth(25%)
        nLabel.pin.vCenter().after(of: icon).width(100).height(50).maxWidth(25%).marginLeft(15)
        stepper.pin.vCenter().right()
    }
    
    private func configure(minimum: Double, maximum: Double) {
        
        let action = UIAction { [weak self] action in
            self?.setLabelTextFromStepper()
        }
            
        stepper.minimumValue = minimum
        stepper.maximumValue = maximum
        stepper.stepValue = 1
        stepper.addAction(action, for: .touchUpInside)
        
        nLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nLabel.textAlignment = .left
        setLabelTextFromStepper()
        
        icon.image = UIImage(systemName: "rectangle.stack")
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .black
    }
    
    public func setLabelTextFromStepper() {
        nLabel.text = "\(stepper.value.noDecimalPointString) 장"
    }
}
