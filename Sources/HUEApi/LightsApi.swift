//
//  LightsApi.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation
import AsyncRequest
import Apic

// We can’t send commands to the lights too fast.
// If you stick to around 10 commands per second to the /lights resource as maximum you should be fine

public class LightsApi: HUEApi {
    
    let username: String
    var scheduler: QueueScheduler<ScheduledSetState>?
    
    public init(url: String, username: String) {
        self.username = username
        super.init(url: url)
    }
    
    /// Gets a list of all lights that have been discovered by the bridge
    public func lights() -> Request<[Light]> {
        return requestObject(route: get(endpoint: "api/\(username)/lights"), transform: { (lights: [String: Light]) in
            lights.forEach({ $1.id = $0 })
            return Array(lights.values)
        })
    }
    
    /// Gets the attributes and state of a given light.
    public func light(id: String) -> Request<Light> {
        return requestObject(route: get(endpoint: "api/\(username)/lights/\(id)"), transform: { (light: Light) in
            light.id = id
            return light
        })
    }
    
    /// Gets a list of lights that were discovered the last time a search for new lights was performed.
    /// The list of new lights is always deleted when a new search is started
    public func newLights() -> Request<NewLightsScan> {
        return requestObject(route: get(endpoint: "api/\(username)/lights/new"), transform: { (result: [String: NewLight]) in
            result.forEach({ $1.id = $0 })
            let state = result.first(where: { $0.key == "lastscan" })?.value.name
            let lights = Array(result.filter({ !$1.delete }).values)
            return NewLightsScan(lights: lights, state: state ?? "")
        })
    }
    
    /// Starts searching for new lights
    ///
    /// The bridge will open the network for 40s. The overall search might take longer since the configuration of (multiple) new devices can take longer.
    ///
    /// If many devices are found the command will have to be issued a second time after discovery time has elapsed.
    /// If the command is received again during search the search will continue for at least an additional 40s.
    /// When the search has finished, new lights will be available using the get new lights command.
    ///
    /// In addition, the new lights will now be available by calling get all lights or by calling get group attributes on group 0.
    /// Group 0 is a special group that cannot be deleted and will always contain all lights known by the bridge.
    ///
    /// - Parameter deviceIds: List of device ids to search,
    ///   The maxiumum number of serial numbers in any request is 10
    /// - Returns: A `Request` that contains a string that details whether the search started successfully.
    public func searchLights(deviceIds: [String]? = nil) -> Request<String> {
        var params: RequestParameters?
        if let ids = deviceIds {
            params = RequestParameters(body: ids)
        }
        return requestObject(route: post(endpoint: "api/\(username)/lights"), parameters: params) { (array: [HUESuccess<[String: String]>]) in
            if let string = array.first?.success?.first?.value {
                return string
            }
            throw HUEAPIError.parsingError
        }
    }
    
    /// Used to rename lights.
    ///
    /// A light can have its name changed when in any state, including when it is unreachable or off.
    /// - Parameter name: The new name for the light.
    ///     If the name is already taken a space and number will be appended by the bridge
    /// - Parameter id: The id of the light to change.
    public func setName(_ name: String, toLightId id: String) {
    }
    
    /// Deletes a light from the bridge.
    public func deleteLight(_ id: String) -> Request<String> {
        return deleteResource(at: delete(endpoint: "/api/\(username)/lights/\(id)"))
    }
    
    /// Allows the user to turn the light on and off, modify the hue and effects.
    public func setState(_ state: SetState, of light: String) -> Request<SetState> {
        let request = URLSessionRequest<SetState>()
        if let scheduler = scheduler, scheduler.shouldSchedule {
            let scheduled = ScheduledSetState(state: state, identifier: light, request: request) {
                self.doSetState(state, of: light, request: request)
            }
            scheduler.scheduleItem(scheduled)
        } else {
            doSetState(state, of: light, request: request)
        }
        return request
    }
    
    private func doSetState(_ state: SetState, of light: String, request: URLSessionRequest<SetState>) {
        let params = RequestParameters(body: state)
        requestObject(route: put(endpoint: "api/\(username)/lights/\(light)/state"), parameters: params, request: request, transform: { (result: [Empty]) in
            return state
        })
    }
}

struct Empty: Decodable {}
