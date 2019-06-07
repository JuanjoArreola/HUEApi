import Foundation
import Apic

public enum HUEAPIError: Error {
    case notAuthenticated
}

public class HUEApi: AbstractRepository {
    
    let baseURL: String
    var username: String?
    
    public init(url: String, username: String?) {
        self.baseURL = url
        self.username = username
        super.init(responseParser: HUEParser())
    }
    
    func get(endpoint: String) -> Route {
        return Route.get(baseURL + endpoint)
    }
    
    func post(endpoint: String) -> Route {
        return Route.post(baseURL + endpoint)
    }
    
    func put(endpoint: String) -> Route {
        return Route.put(baseURL + endpoint)
    }
    
    func delete(endpoint: String) -> Route {
        return Route.delete(baseURL + endpoint)
    }
}
