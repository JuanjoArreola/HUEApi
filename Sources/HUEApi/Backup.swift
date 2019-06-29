//
//  Backup.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/19/19.
//

import Foundation

public class Backup: Decodable {
    public var status: String
    public var errorCode: Int
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "errorcode"
    }
}
