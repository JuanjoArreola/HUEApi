//
//  NewLight.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/24/19.
//

import Foundation

public class NewLight: Decodable {
    public var id: String = ""
    public var name: String = ""
    var delete: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
        } catch is DecodingError {
            name = try decoder.singleValueContainer().decode(String.self)
            delete = true
        }
    }
}

public struct NewLightsScan: Decodable {
    public var lights: [NewLight]
    public var state: String
}
