//
//  NSMutableData+append.swift
//  Util
//
//  Created by Hoen on 2023/04/01.
//

import Foundation

public extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
