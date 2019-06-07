//
//  Configuration.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public class Configuration: Decodable {
    public var name: String
    public var zigbeechannel: Int
    public var mac: String
    public var ipaddress: String
    public var netmask: String
    public var gateway: String
    public var apiversion: String
    public var whitelist: [String: Whitelisted]
}

public class Whitelisted: Decodable {
    public var name: String
    public var lastUse: Date
    public var create: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case lastUse = "last use date"
        case create = "create date"
    }
}
