//
//  InternetServices.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/19/19.
//

import Foundation

public class InternetServices: Decodable {
    public var internet: String
    public var remoteAccess: String
    public var time: String
    public var softwareUpdate: String
    
    enum CodingKeys: String, CodingKey {
        case remoteAccess = "remoteaccess"
        case softwareUpdate = "swupdate"
        case internet, time
    }
}
