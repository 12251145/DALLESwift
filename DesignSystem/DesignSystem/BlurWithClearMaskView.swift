//
//  BlurWithClearMaskView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/26.
//

import PinLayout
import UIKit

public final class BlurWithClearMaskView: UIView {
    private var blurEffectView: UIVisualEffectView
    public var clearArea: CGRect = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public init(blurEffect: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurEffect)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        super.init(frame: .zero)
        
        addSubview(blurEffectView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        blurEffectView.pin.all()
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: bounds)
        let clearPath = UIBezierPath(rect: clearArea)
        path.append(clearPath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        blurEffectView.layer.mask = maskLayer
    }
}
