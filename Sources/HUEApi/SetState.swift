//
//  SetState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public class SetState: Encodable {
    
    /// On/Off state of the light. On=true, Off=false
    public var on: Bool?
    
    public var alert: LightAlert?
    public var effect: LightEffect?
    
    var transitiontime: UInt16?
    
    /// The duration of the transition from the light’s current state to the new state.
    public var transitionTime: TimeInterval? {
        get {
            guard let time = transitiontime else { return nil }
            return TimeInterval(time / 10)
        } set {
            if let time = newValue {
                transitiontime = UInt16((time * 10).clamped(to: 0...65_535))
            }
        }
    }
    
    public init(on: Bool) {
        self.on = on
    }
    
    public init() {}
}

extension SetState: Replaceable {
    
    public func canBeReplacedWith(_ replaceable: Replaceable) -> Bool {
        guard let new = replaceable as? SetState else { return false }
        return on == nil || new.on != nil &&
            alert == nil || new.alert != nil &&
            effect == nil || new.effect != nil
    }
    
    public func replace() {}
}
