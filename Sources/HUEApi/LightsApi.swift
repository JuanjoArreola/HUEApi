//
//  LightsApi.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation
import AsyncRequest
import Apic

public class LightsApi: HUEApi {
    
    public func lights() -> Request<[String: Light]> {
        guard let user = username else {
            return Request.completed(with: HUEAPIError.notAuthenticated, in: .main)
        }
        return requestObject(route: get(endpoint: "api/\(user)/lights"), success: nil)
    }
    
    public func light(id: String) -> Request<Light> {
        guard let user = username else {
            return Request.completed(with: HUEAPIError.notAuthenticated, in: .main)
        }
        return requestObject(route: get(endpoint: "api/\(user)/lights/\(id)"), success: nil)
    }
    
    public func setState(_ state: SetLightState, of light: String) -> Request<Bool> {
        guard let user = username else {
            return Request.completed(with: HUEAPIError.notAuthenticated, in: .main)
        }
        let params = RequestParameters(body: state)
        return requestSuccess(route: put(endpoint: "api/\(user)/lights/\(light)/state"), parameters: params, success: nil)
    }
}
