//
//  FormData.swift
//  RESTAPI
//
//  Created by Hoen on 2023/04/01.
//

import Foundation

public struct FormData {
    public var data: Data
    public var mimeType: String
    public var fileName: String
    
    public init(data: Data, mimeType: String, fileName: String) {
        self.data = data
        self.mimeType = mimeType
        self.fileName = fileName
    }
}
