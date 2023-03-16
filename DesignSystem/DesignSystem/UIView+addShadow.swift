//
//  UIView+addShadow.swift
//  DesignSystem
//
//  Created by Hoen on 2023/03/16.
//

import UIKit

extension UIView {
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize,
        radius: CGFloat
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
}
