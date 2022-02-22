// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userInfo = try? newJSONDecoder().decode(UserInfo.self, from: jsonData)

import Foundation

// MARK: - UserInfo
struct UserInfo: Decodable {
    var results: [Result]?
    let info: Info?
}

// MARK: - Info
struct Info: Decodable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct Result: Decodable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
}

// MARK: - Dob
struct Dob: Decodable {
    let date: String?
    let age: Int?
}

// MARK: - ID
struct ID: Decodable {
    let name, value: String?
}

// MARK: - Location
struct Location: Decodable {
    let street: Street?
    let city, state, country: String?
    let postcode: ValueWrapper
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Decodable {
    let latitude, longitude: String?
}

// MARK: - Street
struct Street: Decodable {
    let number: Int?
    let name: String?
}

// MARK: - Timezone
struct Timezone: Decodable {
    let offset, timezoneDescription: String?

//    enum CodingKeys: String, CodingKey {
//        case offset
//        case timezoneDescription = "description"
//    }
}

// MARK: - Login
struct Login: Decodable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Decodable {
    let title, first, last: String?
}

// MARK: - Picture
struct Picture: Decodable {
    let large, medium, thumbnail: String?
}


enum ValueWrapper: Codable {
    case stringValue(String)
    case intValue(Int)
    case doubleValue(Double)
    case boolValue(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .stringValue(value)
            return
        }
        if let value = try? container.decode(Bool.self) {
            self = .boolValue(value)
            return
        }
        if let value = try? container.decode(Double.self) {
            self = .doubleValue(value)
            return
        }
        if let value = try? container.decode(Int.self) {
            self = .intValue(value)
            return
        }

        throw DecodingError.typeMismatch(ValueWrapper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueWrapper"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .stringValue(value):
            try container.encode(value)
        case let .boolValue(value):
            try container.encode(value)
        case let .intValue(value):
            try container.encode(value)
        case let .doubleValue(value):
            try container.encode(value)
        }
    }

    var rawValue: String {
        var result: String
        switch self {
        case let .stringValue(value):
            result = value
        case let .boolValue(value):
            result = String(value)
        case let .intValue(value):
            result = String(value)
        case let .doubleValue(value):
            result = String(value)
        }
        return result
    }

    var intValue: Int? {
        var result: Int?
        switch self {
        case let .stringValue(value):
            result = Int(value)
        case let .intValue(value):
            result = value
        case let .boolValue(value):
            result = value ? 1 : 0
        case let .doubleValue(value):
            result = Int(value)
        }
        return result
    }

    var boolValue: Bool? {
        var result: Bool?
        switch self {
        case let .stringValue(value):
            result = Bool(value)
        case let .boolValue(value):
            result = value
        case let .intValue(value):
            result = Bool(truncating: value as NSNumber)
        case let .doubleValue(value):
            result = Bool(truncating: value as NSNumber)
        }
        return result
    }
}
