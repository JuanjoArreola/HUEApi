//
//  BasicBridgeConfiguration.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/19/19.
//

import Foundation

public class BasicBridgeConfiguration: Decodable {
    
    /// The unique bridge id. This is currently generated from the bridge Ethernet mac address
    public let bridgeId: String
    
    /// Name of the bridge. This is also its uPnP name, so will reflect the actual uPnP name after any conflicts have been resolved
    public let name: String
    
    /// The version of the datastore
    public let datastoreVersion: String
    
    /// Software version of the bridge
    public let softwareVersion: String
    
    ///The version of the hue API
    public let apiVersion: Version
    
    /// MAC address of the bridge.
    public let mac: String
    
    /// Indicates if bridge settings are factory new
    public let factoryNew: Bool
    
    /// If a bridge backup file has been restored on this bridge from a bridge with a different bridgeid,
    /// it will indicate that bridge id, otherwise it will be null
    public var replacesBridgeId: String?
    
    /// This parameter uniquely identifies the hardware model of the bridge (BSB001, BSB002)
    public let modelId: String
    
    /// Name of the starterkit created in the factory
    public let starterkitId: String
    
    enum CodingKeys: String, CodingKey {
        case name, mac
        case apiVersion = "apiversion"
        case bridgeId = "bridgeid"
        case datastoreVersion = "datastoreversion"
        case factoryNew = "factorynew"
        case modelId = "modelid"
        case replacesBridgeId = "replacesbridgeid"
        case softwareVersion = "swversion"
        case starterkitId = "starterkitid"
    }
}
