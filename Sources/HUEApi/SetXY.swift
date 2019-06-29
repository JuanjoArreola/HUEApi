//
//  SetXY.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public class SetXYColor: SetState {
    public var x: Float?
    public var y: Float?
    
    public init(x: Float, y: Float) {
        self.x = x.clamped(to: 0...1)
        self.y = y.clamped(to: 0...1)
        super.init()
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let x = x, let y = y {
            try container.encode([x, y], forKey: .xy)
        }
        try super.encode(to: encoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case xy
    }
}

public class SetXYIncrement: SetState {
    
    /// Increments or decrements the value of x.
    public var xIncrement: Float?
    
    /// Increments or decrements the value of y
    public var yIncrement: Float?
    
    public init(xIncrement x: Float, yIncrement y: Float) {
        xIncrement = x.clamped(to: 0...1)
        yIncrement = y.clamped(to: 0...1)
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case xy = "xy_inc"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let x = xIncrement, let y = yIncrement {
            try container.encode([x, y], forKey: .xy)
        }
        try super.encode(to: encoder)
    }
}
