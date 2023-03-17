//
//  String?+Validation.swift
//  Util
//
//  Created by Hoen on 2023/03/17.
//

import Foundation

public extension String? {
    func notNilNotEmpty() -> Bool {
        if let self {
            return !self.isEmpty
        } else {
            return false
        }
    }
}
