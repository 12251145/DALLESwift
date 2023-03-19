//
//  DALLECreateImageResponse.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public struct DALLECreateImageResponse: Decodable {
    var created: Int64
    var data: [ResponseFormat]
}
