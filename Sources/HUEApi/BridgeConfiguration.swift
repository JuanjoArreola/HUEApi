//
//  Configuration.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public class BridgeConfiguration: Decodable {
    
    /// The unique bridge id. This is currently generated from the bridge Ethernet mac address
    public var bridgeId: String
    
    /// Name of the bridge. This is also its uPnP name, so will reflect the actual uPnP name after any conflicts have been resolved
    public var name: String
    
    /// The current wireless frequency channel used by the bridge.
    /// It can take values of 11, 15, 20,25 or 0 if undefined (factory new).
    public var zigbeeChannel: Int
    
    /// MAC address of the bridge.
    public var mac: String
    
    /// Whether the IP address of the bridge is obtained with DHCP
    public var dhcp: Bool
    
    /// IP address of the bridge
    public var ipAddress: String
    
    /// Network mask of the bridge
    public var netmask: String
    
    // Gateway IP address of the bridge
    public var gateway: String
    
    /// Current time stored on the bridge.
    public var UTC: Date
    
    /// The local time of the bridge. “none” if not available.
    public var localtime: Date
    
    /// Timezone of the bridge as OlsenIDs, like “Europe/Amsterdam” or “none” when not configured.
    public var timezone: String
    
    /// This parameter uniquely identifies the hardware model of the bridge (BSB001, BSB002)
    public var modelId: String
    
    /// Software version of the bridge
    public var softwareVersion: String

    ///The version of the hue API
    public var apiVersion: Version
    
    /// The version of the datastore
    public var datastoreVersion: String
    
    /// Contains information related to software updates
    public var softwareUpdate2: BridgeSoftwareUpdate
    
    /// Indicates whether the link button has been pressed within the last 30 seconds.
    /// Starting  1.31, Writing is only allowed for Portal access via cloud application_key
    public var linkButton: Bool
    
    /// This indicates whether the bridge is registered to synchronize data with a portal account.
    /// When setting portalservices to true it shall come with a terms and conditions (www.meethue.com/terms)
    /// and privacy notice (www.meethue.com/privacy). A user shall accept it before setting portal services to true
    public var portalServices: Bool
    
    public var portalConnection: String
    
    /// Object representing the portal state
    public var portalState: PortalState
    
    public var internetServices: InternetServices
    
    /// Indicates if bridge settings are factory new
    public var factoryNew: Bool
    
    /// If a bridge backup file has been restored on this bridge from a bridge with a different bridgeid,
    /// it will indicate that bridge id, otherwise it will be null
    public var replacesBridgeId: String?
    
    /// Name of the starterkit created in the factory
    public var starterkitId: String
    
    /// A list of whitelisted user IDs
    public var whitelist: [WhitelistUser] = []
    var _whitelist: [String: WhitelistUser]
    
    enum CodingKeys: String, CodingKey {
        case name, mac, dhcp, netmask, gateway, UTC, localtime, timezone
        case _whitelist = "whitelist"
        case apiVersion = "apiversion"
        case bridgeId = "bridgeid"
        case datastoreVersion = "datastoreversion"
        case factoryNew = "factorynew"
        case internetServices = "internetservices"
        case ipAddress = "ipaddress"
        case linkButton = "linkbutton"
        case modelId = "modelid"
        case portalConnection = "portalconnection"
        case portalServices = "portalservices"
        case portalState = "portalstate"
        case replacesBridgeId = "replacesbridgeid"
        case softwareUpdate2 = "swupdate2"
        case softwareVersion = "swversion"
        case starterkitId = "starterkitid"
        case zigbeeChannel = "zigbeechannel"
    }
}
