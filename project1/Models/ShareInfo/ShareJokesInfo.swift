// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shareJokesInfo = try? newJSONDecoder().decode(ShareJokesInfo.self, from: jsonData)

import Foundation

// MARK: - ShareJokesInfo
struct ShareJokesInfo: Decodable {
    let error: Bool?
    let category, type, joke: String?
    let flags: Flags?
    let id: Int?
    let safe: Bool?
    let lang: String?
}

// MARK: - Flags
struct Flags: Decodable {
    let nsfw, religious, political, racist: Bool?
    let sexist, explicit: Bool?
}
