import Foundation
import AsyncRequest
import Apic

public class GroupsApi: HUEApi {
    
    let username: String
    var scheduler: QueueScheduler<ScheduledSetState>?
    
    public init(url: String, username: String) {
        self.username = username
        super.init(url: url)
    }
    
    /// Gets a list of all groups that have been added to the bridge.
    /// A group is a list of lights that can be created, modified and deleted by a user.
    /// - Returns: A list of all groups in the system, each group has a name and unique identification number.
    public func groups() -> Request<[Group]> {
        return requestObject(route: get(endpoint: "api/\(username)/groups")) { (result: [String: Group]) in
            result.forEach({ $1.id = $0 })
            return Array(result.values)
        }
    }
    
    /// Gets the group attributes, e.g. name, light membership and last command for a given group.
    public func group(id: String) -> Request<Group> {
        return requestObject(route: get(endpoint: "api/\(username)/groups")) { (result: Group) in
            result.id = id
            return result
        }
    }
    
    /// Creates a new group containing the lights specified and optional name.
    /// A new group is created in the bridge with the next available id.
    /// For room creation the room class has to be passed, without class it will get the default: “Other” class.
    public func create(_ group: CreateGroup) -> Request<IdContainer> {
        let params = RequestParameters(body: group)
        return requestObject(route: post(endpoint: "/api/\(username)/groups"), parameters: params) { (result: [HUESuccess<IdContainer>]) in
            if let container = result.first?.success {
                return container
            }
            throw HUEAPIError.parsingError
        }
    }
    
    /// Allows the user to modify the name, light and class membership of a group.
    /// - Returns: A response to a successful PUT request contains confirmation of the arguments passed in.
    /// Note: If the new value is too large to return in the response due to internal memory constraints then a value of “Updated.” is returned.
    public func setAttributes(_ attributes: GroupAttributes, to id: String) -> Request<GroupAttributes> {
        let params = RequestParameters(body: attributes)
        return requestObject(route: put(endpoint: "/api/\(username)/groups/\(id)"), parameters: params) { (result: [HUESuccess<[String: GroupAttributesSuccess]>]) in
            var attributes = GroupAttributes(name: nil, lights: nil, class: nil)
            result.forEach({ attributes.setAttributesSuccess($0.success?.first?.value) })
            return attributes
        }
    }
    
    /// Modifies the state of all lights in a group.
    ///
    /// User created groups will have an ID of 1 or higher; however a special group with
    /// an ID of 0 also exists containing all the lamps known by the bridge.
    public func setState(_ state: SetState, to id: String) -> Request<SetState> {
        let request = URLSessionRequest<SetState>()
        if let scheduler = scheduler, scheduler.shouldSchedule {
            let scheduled = ScheduledSetState(state: state, identifier: id, request: request) {
                self.doSetState(state, to: id, request: request)
            }
            scheduler.scheduleItem(scheduled)
        } else {
            doSetState(state, to: id, request: request)
        }
        return request
    }
    
    private func doSetState(_ state: SetState, to id: String, request: URLSessionRequest<SetState>) {
        requestObject(route: put(endpoint: "/api/\(username)/groups/\(id)/action"), request: request) { (result: [HUESuccess<Empty>]) in
            return state
        }
    }
    
    /// Deletes the specified group from the bridge.
    func deleteGroup(_ id: String) -> Request<String> {
        return requestObject(route: delete(endpoint: "/api/\(username)/groups/\(id)"), transform: { (result: [HUESuccess<String>]) in
            if let string = result.first?.success {
                return string
            }
            throw HUEAPIError.parsingError
        })
    }
}
