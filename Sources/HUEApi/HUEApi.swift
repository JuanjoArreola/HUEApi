import Foundation
import Apic
import AsyncRequest

public enum HUEAPIError: Error {
    case notAuthenticated, replaced, parsingError
}

public class HUEApi: AbstractRepository {
    
    let baseURL: String
    
    public init(url: String) {
        self.baseURL = url
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
    
    public func requestObject<U: Decodable, T>(route: Route, parameters: RequestParameters? = nil, transform: @escaping (U) throws -> T) -> Request<T> {
        let request = URLSessionRequest<T>()
        do {
            request.dataTask = try doRequest(route: route, parameters: parameters, completion: { (data, response, error) in
                do {
                    let object: U = try self.responseParser.object(from: data, response: response, error: error)
                    request.complete(with: try transform(object), in: self.responseQueue)
                } catch {
                    request.complete(with: error, in: self.responseQueue)
                }
            })
        } catch {
            request.complete(with: error, in: responseQueue)
        }
        return request
    }
    
    public func requestObject<U: Decodable, T>(route: Route, parameters: RequestParameters? = nil,
                                               request: URLSessionRequest<T>, transform: @escaping (U) throws -> T) {
        do {
            request.dataTask = try doRequest(route: route, parameters: parameters, completion: { (data, response, error) in
                do {
                    let object: U = try self.responseParser.object(from: data, response: response, error: error)
                    request.complete(with: try transform(object), in: self.responseQueue)
                } catch {
                    request.complete(with: error, in: self.responseQueue)
                }
            })
        } catch {
            request.complete(with: error, in: responseQueue)
        }
    }
}
