// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shareBookInfo = try? newJSONDecoder().decode(ShareBookInfo.self, from: jsonData)

import Foundation

// MARK: - ShareBookInfo
struct ShareBookInfo: Codable {
    let error, total, page: String?
    let books: [Book]?
}

// MARK: - Book
struct Book: Codable {
    let title, subtitle, isbn13, price: String?
    let image: String?
    let url: String?
}
