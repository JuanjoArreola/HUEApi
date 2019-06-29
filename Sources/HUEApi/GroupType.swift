import Foundation

public enum GroupType: String, Codable {
    /// A special group containing all lights in the system, and is not returned by the ‘get all groups’ command.
    /// This group is not visible, and cannot be created, modified or deleted using the API.
    case zero = "0"
    
    /// Multisource luminaire group A lighting installation of default groupings of hue lights.
    /// The bridge will pre-install these groups for ease of use. This type cannot be created manually.
    /// Also, a light can only be in a maximum of one luminaire group. See multisource luminaires for more info.
    case luminaire = "Luminaire"
    
    /// LightGroup group A group of lights that can be controlled together.
    /// This the default group type that the bridge generates for user created groups.
    /// Default type when no type is given on creation.
    case lightsource = "Lightsource"
    
    /// LightGroup group A group of lights that can be controlled together.
    /// This the default group type that the bridge generates for user created groups.
    /// Default type when no type is given on creation.
    case lightGroup = "LightGroup"
    
    /// Room A group of lights that are physically located in the same place in the house.
    /// Rooms behave similar as light groups, except:
    ///     (1) A room can be empty and contain 0 lights,
    ///     (2) a light is only allowed in one room and
    ///     (3) a room isn’t automatically deleted when all lights in that room are deleted.
    case room = "Room"
    
    /// Represents an entertainment setup
    /// Entertainment group describe a group of lights that are used in an entertainment setup.
    /// Locations describe the relative position of the lights in an entertainment setup. E.g. for TV the position is relative to the TV. Can be used to configure streaming sessions.
    
    /// Entertainment group behave in a similar way as light groups, with the exception: it can be empty and contain 0 lights.
    /// The group is also not automatically recycled when lights are deleted. The group of lights can be controlled together as in LightGroup.
    case entertainment = "Entertainment"
    
    case zone = "Zone"
    
    var version: Version {
        switch self {
        case .zero:
            return "1.0"
        case .luminaire, .lightsource, .lightGroup:
            return "1.4"
        case .room:
            return "1.11"
        case .entertainment:
            return "1.22"
        case .zone:
            return "1.30"
        }
    }
}
