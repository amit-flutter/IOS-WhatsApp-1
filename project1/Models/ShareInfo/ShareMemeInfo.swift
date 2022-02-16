// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shareMemeInfo = try? newJSONDecoder().decode(ShareMemeInfo.self, from: jsonData)

import Foundation

// MARK: - ShareMemeInfo
struct ShareMemeInfo: Decodable {
    let success: Bool?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    var memes: [Meme]?
}

// MARK: - Meme
struct Meme: Decodable {
    let id, name: String?
    let url: String?
    let width, height, boxCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
}
