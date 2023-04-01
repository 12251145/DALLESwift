//
//  UIImage+resize.swift
//  Util
//
//  Created by Hoen on 2023/04/02.
//

import UIKit

public extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
