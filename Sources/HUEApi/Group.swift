//
//  Group.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/16/19.
//

import Foundation

public class Group: Decodable {
    public var id: String = ""
    
    /// A unique, editable name given to the group.
    public let name: String
    
    /// If not provided upon creation “LightGroup” is used.
    public let type: GroupType
    public let lights: [String]
    public let sensors: [Sensor]
    
    /// Category of Room types. Default is: Other.
    public let `class`: RoomClass
    public let recycle: Bool
    
    /// The light state of one of the lamps in the group.
    public let action: ColorState
    public let state: GroupState
}

public class Sensor: Decodable {
}

public struct GroupState: Decodable {
    public var allOn: Bool
    public var anyOn: Bool
    
    enum CodingKeys: String, CodingKey {
        case allOn = "all_on"
        case anyOn = "any_on"
    }
}
