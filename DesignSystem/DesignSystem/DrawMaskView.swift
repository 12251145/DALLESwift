//
//  DrawMaskView.swift
//  DesignSystem
//
//  Created by Hoen on 2023/04/03.
//

import PinLayout
import UIKit

public final class DrawMaskView: UIView {
    
    private var imageView = UIImageView()
    private var drawImageView = UIImageView()
    private var tempImageView = UIImageView()
    
    public var originImage: UIImage? {
        didSet {
            imageView.image = originImage
        }
    }
    
    public var doneButton = SFSymbolButton(symbolName: "checkmark", size: 13, color: .white)
    public var deleteMaskButton = SFSymbolButton(symbolName: "trash", size: 13, color: .white)
    public var cancelButton = SFSymbolButton(symbolName: "xmark", size: 13, color: .white)
    
    private var lastPoint: CGPoint = .zero
    private var color: UIColor = .white
    
    private var brushWidth: CGFloat = 20.0
    private var swiped = false
    
    public init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .black
        self.addSubview(imageView)
        self.addSubview(tempImageView)
        self.addSubview(drawImageView)
        self.addSubview(doneButton)
        self.addSubview(deleteMaskButton)
        self.addSubview(cancelButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func maskedImage() -> UIImage? {
        guard let originImage else { return nil }
        UIGraphicsBeginImageContext(originImage.size)
        imageView.image?.draw(in: .init(origin: .zero, size: originImage.size), blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: .init(origin: .zero, size: originImage.size), blendMode: .destinationOut, alpha: 1.0)
        
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return maskedImage
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.size.width
        imageView.pin.top(pin.safeArea.top + 50).left().right().height(width)
        tempImageView.pin.top(pin.safeArea.top + 50).left().right().height(width)
        drawImageView.pin.top(pin.safeArea.top + 50).left().right().height(width)
        
        doneButton.pin.bottom(pin.safeArea.bottom + 60).hCenter().width(50).height(50)
        deleteMaskButton.pin.bottom(pin.safeArea.bottom + 60).before(of: doneButton).width(50).height(50).marginRight(60)
        cancelButton.pin.bottom(pin.safeArea.bottom + 60).after(of: doneButton).width(50).height(50).marginLeft(60)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        swiped = false
        lastPoint = touch.location(in: drawImageView)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        swiped = true
        let currentPoint = touch.location(in: drawImageView)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
          drawLine(from: lastPoint, to: lastPoint)
        }

        UIGraphicsBeginImageContext(tempImageView.frame.size)
        tempImageView.image?.draw(in: tempImageView.bounds, blendMode: .normal, alpha: 1.0)
        drawImageView.image?.draw(in: tempImageView.bounds, blendMode: .normal, alpha: 1.0)
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawImageView.image = nil
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(drawImageView.bounds.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawImageView.image?.draw(in: drawImageView.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        context.strokePath()
        
        drawImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
