
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shareWeatherInfo = try? newJSONDecoder().decode(ShareWeatherInfo.self, from: jsonData)

import Foundation

// MARK: - ShareWeatherInfo
struct ShareWeatherInfo: Codable {
    let region: String?
    let currentConditions: CurrentConditions?
    var nextDays: [NextDay]?
    let contactAuthor: ContactAuthor?
    let dataSource: String?

    enum CodingKeys: String, CodingKey {
        case region, currentConditions
        case nextDays = "next_days"
        case contactAuthor = "contact_author"
        case dataSource = "data_source"
    }
}

// MARK: - ContactAuthor
struct ContactAuthor: Codable {
    let email, authNote: String?

    enum CodingKeys: String, CodingKey {
        case email
        case authNote = "auth_note"
    }
}

// MARK: - CurrentConditions
struct CurrentConditions: Codable {
    let dayhour: String?
    let temp: Temp?
    let precip, humidity: String?
    let wind: Wind?
    let iconURL: String?
    let comment: String?
}

// MARK: - Temp
struct Temp: Codable {
    let c, f: Int?
}

// MARK: - Wind
struct Wind: Codable {
    let km, mile: Int?
}

// MARK: - NextDay
struct NextDay: Codable {
    let day, comment: String?
    let maxTemp, minTemp: Temp?
    let iconURL: String?

    enum CodingKeys: String, CodingKey {
        case day, comment
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case iconURL
    }
}
