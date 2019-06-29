//
//  SetScene.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public class SetScene: SetState {
    public var scene: String?
    
    public init(scene: String) {
        self.scene = scene
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case scene
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scene, forKey: .scene)
        
        try super.encode(to: encoder)
    }
}
