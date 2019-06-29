//
//  WhitelistedUser.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/18/19.
//

import Foundation

public class WhitelistUserProperties: Decodable {
    public var name: String
    public var lastUse: Date
    public var create: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case lastUse = "last use date"
        case create = "create date"
    }
}

public class WhitelistUser: WhitelistUserProperties {
    public var id: String = ""
}
