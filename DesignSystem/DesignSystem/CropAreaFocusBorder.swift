//
//  CropAreaFocusBorder.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/26.
//

import UIKit

public final class CropAreaFocusBorder: CALayer {
    let segment: CGFloat = 20
    public let lineWidth: CGFloat

    public var dw: CGFloat {
        lineWidth / 2
    }
    
    public init(lineWidth: CGFloat = 8) {
        self.lineWidth = lineWidth
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(in ctx: CGContext) {

        
        let boundWidth: CGFloat = bounds.size.width
        let boundHeight: CGFloat = bounds.size.height
        
        let point1 = CGPoint(x: dw, y: segment + dw)
        let point2 = CGPoint(x: dw, y: dw)
        let point3 = CGPoint(x: segment + dw, y: dw)
        
        let point4 = CGPoint(x: (boundWidth / 2) - (segment / 2) - dw, y: dw)
        let point5 = CGPoint(x: (boundWidth / 2) + (segment / 2) + dw, y: dw)
        
        let point6 = CGPoint(x: boundWidth - segment - dw, y: dw)
        let point7 = CGPoint(x: boundWidth - dw, y: dw)
        let point8 = CGPoint(x: boundWidth - dw, y: segment + dw)
        
        let point9 = CGPoint(x: boundWidth - dw, y: (boundHeight / 2) - (segment / 2) - dw)
        let point10 = CGPoint(x: boundWidth - dw, y: (boundHeight / 2) + (segment / 2) + dw)
        
        let point11 = CGPoint(x: boundWidth - dw, y: boundHeight - segment - dw)
        let point12 = CGPoint(x: boundWidth - dw, y: boundHeight - dw)
        let point13 = CGPoint(x: boundWidth - segment - dw, y: boundHeight - dw)
        
        let point14 = CGPoint(x: (boundWidth / 2) + (segment / 2) + dw, y: boundHeight - dw)
        let point15 = CGPoint(x: (boundWidth / 2) - (segment / 2) - dw, y: boundHeight - dw)
        
        let point16 = CGPoint(x: segment + dw, y: boundHeight - dw)
        let point17 = CGPoint(x: dw, y: boundHeight - dw)
        let point18 = CGPoint(x: dw, y: boundHeight - segment - dw)
        
        let point19 = CGPoint(x: dw, y: (boundHeight / 2) + (segment / 2) + dw)
        let point20 = CGPoint(x: dw, y: (boundHeight / 2) - (segment / 2) - dw)
        
        
        let path = UIBezierPath()
        
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        
        path.move(to: point4)
        path.addLine(to: point5)
        
        path.move(to: point6)
        path.addLine(to: point7)
        path.addLine(to: point8)
        
        path.move(to: point9)
        path.addLine(to: point10)
        
        path.move(to: point11)
        path.addLine(to: point12)
        path.addLine(to: point13)
        
        path.move(to: point14)
        path.addLine(to: point15)
        
        path.move(to: point16)
        path.addLine(to: point17)
        path.addLine(to: point18)
        
        path.move(to: point19)
        path.addLine(to: point20)
        
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(lineWidth)
        ctx.addPath(path.cgPath)
        ctx.strokePath()
    }
}
