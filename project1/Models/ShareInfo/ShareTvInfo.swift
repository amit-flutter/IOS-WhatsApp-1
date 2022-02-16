// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shareTvInfo = try? newJSONDecoder().decode(ShareTvInfo.self, from: jsonData)

import Foundation

// MARK: - ShareTvInfoElement
struct ShareTvInfoElement: Decodable {
    let id: Int?
    let url: String?
    let name, type, language: String?
    let genres: [String]?
    let status: String?
    let runtime, averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Decodable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Decodable {
    let medium, original: String?
}

// MARK: - Links
struct Links: Decodable {
    let linksSelf, previousepisode: Previousepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}

// MARK: - Previousepisode
struct Previousepisode: Decodable {
    let href: String?
}

// MARK: - Network
struct Network: Decodable {
    let id: Int?
    let name: String?
    let country: Country?
}

// MARK: - Country
struct Country: Decodable {
    let name, code, timezone: String?
}

// MARK: - Rating
struct Rating: Decodable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Decodable {
    let time: String?
    let days: [String]?
}

typealias ShareTvInfo = [ShareTvInfoElement]

// MARK: - Encode/decode helpers

//class JSONNull: Decodable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        // No-op
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
