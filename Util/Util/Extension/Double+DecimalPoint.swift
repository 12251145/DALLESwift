//
//  Double+DecimalPoint.swift
//  Util
//
//  Created by Hoen on 2023/03/22.
//

import Foundation

public extension Double {
    var noDecimalPointString: String {
        String(format: "%.0f", self)
    }
}
