//
//  HUEParser.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import Foundation
import Apic

class HUEParser: DefaultResponseParser, CustomDateParsing {
    
    public var dateFormats: [String] {
        return ["y-MM-dd'T'HH:mm:ss", "'T'HH:mm:ss", "y-MM-dd"]
    }
    
    override func getErrorContainer(from data: Data) throws -> ErrorContainerProtocol {
        let errors = try decoder.decode(Array<HUEErrors>.self, from: data)
        return HUEErrorContainer(errors: errors)
    }
    
    override func getContainer<T>(from data: Data, response: URLResponse?) throws -> ResponseContainer<T> where T : Decodable {
        let object = try decoder.decode(T.self, from: data)
        return ResponseContainer(object: object)
    }
}

struct HUESuccess<T: Decodable>: Decodable {
    var success: T?
}

public struct HUEErrors: Decodable {
    var error: HUEError
}

struct HUEErrorContainer: ErrorContainerProtocol {
    
    var errors: [HUEError]
    
    init(errors: [HUEErrors]) {
        self.errors = errors.map({ $0.error })
    }
    
    func getError() -> Error? {
        if errors.isEmpty { return nil }
        if errors.count == 1 {
            return errors.first
        }
        return HUECompositeError(errors: errors)
    }
}
