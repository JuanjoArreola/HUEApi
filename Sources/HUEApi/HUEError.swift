//
//  HUEError.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public struct HUEError: Error, Decodable {
    public var type: Int
    public var address: String
    public var description: String
}

public struct HUECompositeError: Error {
    var errors: [Error]
}
