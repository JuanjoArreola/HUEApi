//
//  SetTemperature.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public class SetColorTemperature: SetState {
    public var temperature: UInt16?
    
    public init(temperature: UInt16) {
        self.temperature = temperature
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case temperature = "ct"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temperature, forKey: .temperature)
        
        try super.encode(to: encoder)
    }
}

public class SetTemperatureIncrement: SetState {
    
    /// Increments or decrements the value of the hue.
    public var temperatureIncrement: Int?
    
    public init(temperatureIncrement temperature: Int) {
        self.temperatureIncrement = temperature.clamped(to: -65_534...65_534)
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case temperatureIncrement = "ct_inc"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temperatureIncrement, forKey: .temperatureIncrement)
        try super.encode(to: encoder)
    }
}
