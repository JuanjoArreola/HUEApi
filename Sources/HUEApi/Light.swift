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

public struct SetLightState: Encodable {
    public var on: Bool?
    public var brightness: UInt8?
    public var hue: UInt16?
    public var saturation: UInt8?
    
    public init(on: Bool) {
        self.on = on
    }
    
    public init(brightness: UInt8, hue: UInt16, saturation: UInt8) {
        self.brightness = brightness
        self.hue = hue
        self.saturation = saturation
    }
    
    public init(brightness: UInt8) {
        self.brightness = brightness
    }
    
    public init(hue: UInt16, saturation: UInt8) {
        self.hue = hue
        self.saturation = saturation
    }
    
    enum CodingKeys: String, CodingKey {
        case on, hue
        case brightness = "bri"
        case saturation = "sat"
    }
}
