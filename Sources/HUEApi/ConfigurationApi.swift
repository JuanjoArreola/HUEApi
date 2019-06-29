//
//  ConfigurationApi.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation
import AsyncRequest
import Apic

public class ConfigurationApi: HUEApi {
    
    public func createUser(named: String, app: String) -> Request<HUEUser> {
        let params = RequestParameters(body: NewUser(devicetype: "\(app)#\(named)"))
        return requestObject(route: post(endpoint: "api"), parameters: params, transform: { (array: [HUESuccess<HUEUser>]) in
            if let user = array.first?.success {
                return user
            }
            throw HUEAPIError.parsingError
        })
    }
    
    public func basicConfiguration() -> Request<BasicBridgeConfiguration> {
        return requestObject(route: get(endpoint: "api/config"), success: nil)
    }
    
    public func configuration(username: String) -> Request<BridgeConfiguration> {
        return requestObject(route: get(endpoint: "api/\(username)/config"), transform: { (configuration: BridgeConfiguration) in
            configuration.whitelistDictionary.forEach({ $1.id = $0 })
            configuration.whitelist = Array(configuration.whitelistDictionary.values)
            return configuration
        })
    }
    
    public func deleteUser(_ user: WhitelistUser, username: String) -> Request<String> {
        return deleteUserWithId(user.id, username: username)
    }
    
    public func deleteUserWithId(_ id: String, username: String) -> Request<String> {
        return requestObject(route: delete(endpoint: "api/\(username)/config/whitelist/\(id)")) { (result: [HUESuccess<String>]) in
            if let string = result.first?.success {
                return string
            }
            throw HUEAPIError.parsingError
        }
    }
}

public class HUEUser: Codable, CustomDebugStringConvertible {
    public var username: String
    
    public var debugDescription: String {
        return "💡👨‍🔧 \(username)"
    }
}
