//
//  Light.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public class Light: Decodable, CustomDebugStringConvertible {
    public var id: String = ""
    
    /// A fixed name describing the type of light e.g. “Extended color light”
    public let type: String
    
    /// A unique, editable name given to the light.
    public let name: String
    
    /// The hardware model of the light.
    public let modelId: String
    
    /// Details the state of the light, see the state table below for more details.
    public let state: LightState
    
    /// Unique id of the device.
    /// The MAC address of the device with a unique endpoint id in the form: AA:BB:CC:DD:EE:FF:00:11-XX
    public let uniqueId: String
    
    /// The manufacturer name.
    public let manufacturerName: String
    
    public let softwareUpdate: SoftwareUpdate
    
    /// Unique ID of the luminaire the light is a part of in the format: AA:BB:CC:DD-XX-YY.
    ///AA:BB:, … represents the hex of the luminaireid, XX the lightsource position (incremental but may contain gaps) and YY the lightpoint position (index of light in luminaire group).
    /// A gap in the lightpoint position indicates an incomplete luminaire (light search required to discover missing light points in this case).
    public var luminaireUniqueId: String?
    
    enum CodingKeys: String, CodingKey {
        case type, name, state
        case modelId = "modelid"
        case uniqueId = "uniqueid"
        case manufacturerName = "manufacturername"
        case luminaireUniqueId = "luminaireuniqueid"
        case softwareUpdate = "swupdate"
    }
    
    public var debugDescription: String {
        return "💡[\(id)]: \(name)"
    }
}
