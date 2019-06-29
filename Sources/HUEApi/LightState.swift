//
//  LightState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/16/19.
//

import Foundation

public class LightState: ColorState {
    
    /// Indicates if a light can be reached by the bridge.
    public var reachable: Bool
    
    enum LightCodingKeys: String, CodingKey {
        case reachable
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LightCodingKeys.self)
        reachable = try container.decode(Bool.self, forKey: .reachable)
        
        try super.init(from: decoder)
    }
}
