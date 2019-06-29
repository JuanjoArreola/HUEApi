//
//  PortalState.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/19/19.
//

import Foundation

public class PortalState: Decodable {
    public var signedOn: Bool
    public var incoming: Bool
    public var outgoing: Bool
    public var communication: String
    
    enum CodingKeys: String, CodingKey {
        case signedOn = "signedon"
        case incoming, outgoing, communication
    }
}
