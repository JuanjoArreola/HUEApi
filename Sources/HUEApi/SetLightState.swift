//
//  SetLightState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/9/19.
//

import Foundation

public struct SetLightState: Encodable {
    public var on: Bool?
    public var brightness: UInt8?
    public var hue: UInt16?
    public var saturation: UInt8?
    
    public init(on: Bool) {
        self.on = on
    }
    
    public init(brightness: UInt8, hue: UInt16, saturation: UInt8) {
        self.init(brightness: brightness)
        self.init(hue: hue, saturation: saturation)
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

extension SetLightState {
    var replaceMask: Int {
        var result = 0
        result |= on == nil ? 0 : 1 << 0
        result |= brightness == nil ? 0 : 1 << 1
        result |= hue == nil ? 0 : 1 << 2
        result |= saturation == nil ? 0 : 1 << 3
        return result
    }
    
    func canBeReplaced(with state: SetLightState) -> Bool {
        return replaceMask == state.replaceMask
    }
}
