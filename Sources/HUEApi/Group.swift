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
    public var name: String
    
    /// If not provided upon creation “LightGroup” is used.
    public var type: GroupType
    public var lights: [String]
    public var sensors: [Sensor]
    
    /// Category of Room types. Default is: Other.
    public var `class`: RoomClass
    public var recycle: Bool
    
    /// The light state of one of the lamps in the group.
    public var action: ColorState
    public var state: GroupState
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
