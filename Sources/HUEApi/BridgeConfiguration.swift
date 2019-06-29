//
//  Configuration.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation

public class BridgeConfiguration: Decodable {
    
    /// The unique bridge id. This is currently generated from the bridge Ethernet mac address
    public let bridgeId: String
    
    /// Name of the bridge. This is also its uPnP name, so will reflect the actual uPnP name after any conflicts have been resolved
    public let name: String
    
    /// The current wireless frequency channel used by the bridge.
    /// It can take values of 11, 15, 20,25 or 0 if undefined (factory new).
    public let zigbeeChannel: Int
    
    /// MAC address of the bridge.
    public let mac: String
    
    /// Whether the IP address of the bridge is obtained with DHCP
    public let dhcp: Bool
    
    /// IP address of the bridge
    public let ipAddress: String
    
    /// Network mask of the bridge
    public let netmask: String
    
    // Gateway IP address of the bridge
    public let gateway: String
    
    /// Current time stored on the bridge.
    public let UTC: Date
    
    /// The local time of the bridge. “none” if not available.
    public let localtime: Date
    
    /// Timezone of the bridge as OlsenIDs, like “Europe/Amsterdam” or “none” when not configured.
    public let timezone: String
    
    /// This parameter uniquely identifies the hardware model of the bridge (BSB001, BSB002)
    public let modelId: String
    
    /// Software version of the bridge
    public let softwareVersion: String

    ///The version of the hue API
    public let apiVersion: Version
    
    /// The version of the datastore
    public let datastoreVersion: String
    
    /// Contains information related to software updates
    public let softwareUpdate2: BridgeSoftwareUpdate
    
    /// Indicates whether the link button has been pressed within the last 30 seconds.
    /// Starting  1.31, Writing is only allowed for Portal access via cloud application_key
    public let linkButton: Bool
    
    /// This indicates whether the bridge is registered to synchronize data with a portal account.
    /// When setting portalservices to true it shall come with a terms and conditions (www.meethue.com/terms)
    /// and privacy notice (www.meethue.com/privacy). A user shall accept it before setting portal services to true
    public let portalServices: Bool
    
    public let portalConnection: String
    
    /// Object representing the portal state
    public let portalState: PortalState
    
    public let internetServices: InternetServices
    
    /// Indicates if bridge settings are factory new
    public let factoryNew: Bool
    
    /// If a bridge backup file has been restored on this bridge from a bridge with a different bridgeid,
    /// it will indicate that bridge id, otherwise it will be null
    public let replacesBridgeId: String?
    
    /// Name of the starterkit created in the factory
    public let starterkitId: String
    
    /// A list of whitelisted user IDs
    public var whitelist: [WhitelistUser] = []
    let whitelistDictionary: [String: WhitelistUser]
    
    enum CodingKeys: String, CodingKey {
        case name, mac, dhcp, netmask, gateway, UTC, localtime, timezone
        case whitelistDictionary = "whitelist"
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
