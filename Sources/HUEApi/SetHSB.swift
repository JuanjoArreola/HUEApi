//
//  SetHSB.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public class SetHSBColor: SetState {
    public var hue: UInt16?
    public var saturation: UInt8?
    public var brightness: UInt8?
    
    public convenience init(hue: UInt16, saturation: UInt8, brightness: UInt8) {
        self.init(hue: hue, saturation: saturation)
        self.init(brightness: brightness)
    }
    
    public init(hue: UInt16, saturation: UInt8) {
        self.hue = hue
        self.saturation = saturation.clamped(to: 0...254)
        super.init()
    }
    
    public init(brightness: UInt8) {
        self.brightness = brightness.clamped(to: 0...254)
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case hue
        case brightness = "bri"
        case saturation = "sat"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hue, forKey: .hue)
        try container.encodeIfPresent(saturation, forKey: .saturation)
        try container.encodeIfPresent(brightness, forKey: .brightness)
        try super.encode(to: encoder)
    }
}

public class SetHSBIncrement: SetState {
    
    /// Increments or decrements the value of the hue.
    public var hueIncrement: Int?
    
    /// Increments or decrements the value of the saturation
    public var saturationIncrement: Int?
    
    /// Increments or decrements the value of the brightness.
    public var brightnessIncrement: Int?
    
    public init(hueIncrement hue: Int, saturationIncrement saturation: Int) {
        self.hueIncrement = hue.clamped(to: -65_534...65_534)
        self.saturationIncrement = saturation.clamped(to: -254...254)
        super.init()
    }
    
    public init(brightnessIncrement brightness: Int) {
        self.brightnessIncrement = brightness.clamped(to: -254...254)
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case hueIncrement = "hue_inc"
        case saturationIncrement = "sat_inc"
        case brightnessIncrement = "bri_inc"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(hueIncrement, forKey: .hueIncrement)
        try container.encodeIfPresent(saturationIncrement, forKey: .saturationIncrement)
        try container.encodeIfPresent(brightnessIncrement, forKey: .brightnessIncrement)
        try super.encode(to: encoder)
    }
}
