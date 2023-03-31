//
//  UIImage+pngBase64.swift
//  Util
//
//  Created by Hoen on 2023/03/31.
//

import UIKit

public extension UIImage {
    var pngBase64: String? {
        guard let data = pngData() else { return nil }
        
        let string = data.base64EncodedString()
        return string
    }
}
