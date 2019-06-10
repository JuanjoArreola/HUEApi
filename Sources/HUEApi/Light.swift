//
//  Light.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public class LightState: Decodable {
    public var on: Bool
    public var brightness: UInt8?
    public var hue: Int
    public var saturation: Int
    public var reachable: Bool
    
    enum CodingKeys: String, CodingKey {
        case on, hue, reachable
        case brightness = "bri"
        case saturation = "sat"
    }
}

public class Light: Decodable, CustomDebugStringConvertible {
    public var type: String
    public var name: String
    public var state: LightState
    
    public var debugDescription: String {
        return "💡 \(name)"
    }
}
