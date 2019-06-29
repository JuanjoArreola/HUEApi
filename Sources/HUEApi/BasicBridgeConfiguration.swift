//
//  BasicBridgeConfiguration.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/19/19.
//

import Foundation

public class BasicBridgeConfiguration: Decodable {
    
    /// The unique bridge id. This is currently generated from the bridge Ethernet mac address
    public var bridgeId: String
    
    /// Name of the bridge. This is also its uPnP name, so will reflect the actual uPnP name after any conflicts have been resolved
    public var name: String
    
    /// The version of the datastore
    public var datastoreVersion: String
    
    /// Software version of the bridge
    public var softwareVersion: String
    
    ///The version of the hue API
    public var apiVersion: Version
    
    /// MAC address of the bridge.
    public var mac: String
    
    /// Indicates if bridge settings are factory new
    public var factoryNew: Bool
    
    /// If a bridge backup file has been restored on this bridge from a bridge with a different bridgeid,
    /// it will indicate that bridge id, otherwise it will be null
    public var replacesBridgeId: String?
    
    /// This parameter uniquely identifies the hardware model of the bridge (BSB001, BSB002)
    public var modelId: String
    
    /// Name of the starterkit created in the factory
    public var starterkitId: String
    
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
