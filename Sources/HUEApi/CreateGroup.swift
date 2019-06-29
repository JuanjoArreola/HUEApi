//
//  CreateGroup.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public struct CreateGroup: Encodable {
    public var lights: [String]
    public var name: String?
    public var type: GroupType
    public var `class`: RoomClass?
}

public struct IdContainer: Decodable {
    public var id: String
}
