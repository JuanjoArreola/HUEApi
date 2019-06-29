//
//  GroupAttributes.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/28/19.
//

import Foundation

public struct GroupAttributes: Encodable {
    public var name: String?
    public var lights: [String]?
    public var `class`: RoomClass?
    
    mutating func setAttributesSuccess(_ success: GroupAttributesSuccess?) {
        self.name = success?.name ?? self.name
        self.class = success?.class ?? self.class
        self.lights = success?.lights ?? self.lights
    }
}

struct GroupAttributesSuccess: Decodable {
    public var name: String?
    public var lights: [String]?
    public var `class`: RoomClass?
    
    init(from decoder: Decoder) throws {
        if let `class`: RoomClass = decodeSingleValue(from: decoder) {
            self.class = `class`
        } else if let name: String = decodeSingleValue(from: decoder) {
            self.name = name
        } else if let lights = decodeLights(from: decoder) {
            self.lights = lights
        } else {
            throw HUEAPIError.parsingError
        }
    }
    
    func decodeSingleValue<T: Decodable>(from decoder: Decoder) -> T? {
        do {
            let container = try decoder.singleValueContainer()
            return try container.decode(T.self)
        } catch {
            return nil
        }
    }
    
    func decodeLights(from decoder: Decoder) -> [String]? {
        do {
            var container = try decoder.unkeyedContainer()
            return try container.decode([String].self)
        } catch {
            return nil
        }
    }
}
