//
//  RoomClass.swift
//  HUEApi
//
//  Created by Juan Jose Arreola Simon on 6/16/19.
//

import Foundation

public enum RoomClass: String, Codable {
    case livingRoom = "Living room"
    case kitchen = "Kitchen"
    case dining = "Dining"
    case bedroom = "Bedroom"
    case kidsBedroom = "Kids bedroom"
    case bathroom = "Bathroom"
    case nursery = "Nursery"
    case recreation = "Recreation"
    case office = "Office"
    case gym = "Gym"
    case hallway = "Hallway"
    case toilet = "Toilet"
    case frontDoor = "Front door"
    case garage = "Garage"
    case terrace = "Terrace"
    case garden = "Garden"
    case driveway = "Driveway"
    case carportOther = "CarportOther"
    case home = "Home"
    case downstairs = "Downstairs"
    case upstairs = "Upstairs"
    case topFloor = "Top floor"
    case attic = "Attic"
    case guestRoom = "Guest room"
    case staircase = "Staircase"
    case lounge = "Lounge"
    case manCave = "Man cave"
    case computer = "Computer"
    case studio = "Studio"
    case music = "Music"
    case tv = "TV"
    case reading = "Reading"
    case closet = "Closet"
    case storage = "Storage"
    case laundryRoom = "Laundry room"
    case balcony = "Balcony"
    case porch = "Porch"
    case barbecue = "Barbecue"
    case pool = "Pool"
    
    var version: Version {
        switch self {
        case .livingRoom, .kitchen, .dining, .bedroom, .kidsBedroom, .bathroom, .nursery, .recreation, .office,
             .gym, .hallway, .toilet, .frontDoor, .garage, .terrace, .garden, .driveway, .carportOther:
            return Version(1, 0)
        case .home, .downstairs, .upstairs, .topFloor, .attic, .guestRoom, .staircase, .lounge, .manCave, .computer,
             .studio, .music, .tv, .reading, .closet, .storage, .laundryRoom, .balcony, .porch, .barbecue, .pool:
            return Version(1, 30)
        }
    }
}
