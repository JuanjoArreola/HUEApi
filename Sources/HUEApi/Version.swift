import Foundation

public enum VersionError: Error {
    case invalidVersion
}

public struct Version {
    
    public let major: Int
    public let minor: Int
    public let patch: Int?
    
    public init(_ major: Int, _ minor: Int, _ patch: Int? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
}

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        let lhsComparators = [lhs.major, lhs.minor, lhs.patch ?? 0]
        let rhsComparators = [rhs.major, rhs.minor, rhs.patch ?? 0]
        
        if lhsComparators != rhsComparators {
            return lhsComparators.lexicographicallyPrecedes(rhsComparators)
        }
        return false
    }
}

extension Version: CustomStringConvertible {
    public var description: String {
        if let patch = patch {
            return "\(major).\(minor).\(patch)"
        }
        return "\(major).\(minor)"
    }
}

extension Version: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

extension Version: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        if let version = Version(value) {
            self.init(version)
        } else {
            throw VersionError.invalidVersion
        }
    }
}

extension Version: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        if let version = Version(value) {
            self.init(version)
        } else {
            self.init(0, 0)
        }
    }
}

extension Version {
    
    public init(_ version: Version) {
        major = version.major
        minor = version.minor
        patch = version.patch
    }
    
    public init?(_ versionString: String) {
        let requiredComponents = versionString
            .split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false)
            .map(String.init)
            .compactMap({ Int($0) })
            .filter({ $0 >= 0 })
        
        guard requiredComponents.count >= 2 else { return nil }
        
        self.major = requiredComponents[0]
        self.minor = requiredComponents[1]
        if requiredComponents.count > 2 {
            self.patch = requiredComponents[2]
        } else {
            self.patch = nil
        }
    }
}
