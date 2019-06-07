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
        return requestObject(route: post(endpoint: "api"), parameters: params, success: nil)
    }
    
    public func configuration() -> Request<Configuration> {
        guard let user = username else {
            return Request.completed(with: HUEAPIError.notAuthenticated, in: .main)
        }
        return requestObject(route: get(endpoint: "api/\(user)/config"), success: nil)
    }
}

private struct NewUser: Encodable {
    var devicetype: String
}

public class HUEUser: Codable {
    public var username: String
}
