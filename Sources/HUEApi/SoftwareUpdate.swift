//
//  SoftwareUpdate.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/18/19.
//

import Foundation

public class BridgeSoftwareUpdate: Decodable {
    
    /// Software update object of bridge
    public let bridge: SoftwareUpdate
    
    /// State of software update for the system
    public let state: SoftwareUpdateState
    
    /// Setting this flag true lets the bridge search for software update at the portal.
    /// After the search attempt, this flag is reset to false. Requires portal connection to update software.
    /// If software update server cannot be reached /config/internetservices/swupdate will be “disconnected”.
    public var checkForUpdate: Bool
    
    /// Timestamp of last change in system configuration
    /// - last software configuration update requires additional software to be transferred (noupdates -> transferring)
    /// - last successful transfer of a software image to a device
    /// last successful installation of a software image on a device
    public let lastChange: Date
    
    /// Automatic update configuration
    public let autoinstall: Autoinstall
    
    enum CodingKeys: String, CodingKey {
        case bridge, state, autoinstall
        case checkForUpdate = "checkforupdate"
        case lastChange = "lastchange"
    }
}

public class SoftwareUpdate: Decodable {
    public var state: String
    public var lastInstall: Date
    
    enum CodingKeys: String, CodingKey {
        case state
        case lastInstall = "lastinstall"
    }
}

public class Autoinstall: Decodable {
    public let updatetime: Date
    
    /// Indicates if automatic update is activated. Default is false
    public let on: Bool
}

public enum SoftwareUpdateState: String, Codable {
    /// System does not know if new updates are available  (no connection to update server for multiple days)
    case unknown
    
    /// No updates available
    case noUpdates = "noupdates"
    
    /// Updates are being transferred to devices
    case transferring
    
    /// At least one SW update can be installed
    case anyReadyToInstall = "anyreadytoinstall"
    
    /// All (known) SW updates can be installed
    case allReadyToInstall = "allreadytoinstall"
    
    /// System update is installing. System and/or Devices might not be available for a few minutes
    case installing
}
