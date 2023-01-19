
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ApiAntwort: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, name: String?
    let level: String?
    let evolvesFrom: String?
    let number, artist: String?
    let images: DatumImages
    let cardmarket: Cardmarket?
    let evolvesTo: [String]?
    let regulationMark: String?

    enum CodingKeys: String, CodingKey {
        case id, name, level, evolvesFrom
        case number, artist, images, cardmarket, evolvesTo, regulationMark
    }
}

// MARK: - Cardmarket
struct Cardmarket: Codable {
    let url: String
    let prices: [String: Double]?
}

// MARK: - DatumImages
struct DatumImages: Codable {
    let small, large: String
}

enum Rarity: String, Codable {
    case common = "Common"
    case promo = "Promo"
    case rare = "Rare"
    case rareHolo = "Rare Holo"
    case rareHoloEX = "Rare Holo EX"
    case rareHoloGX = "Rare Holo GX"
    case rareHoloV = "Rare Holo V"
    case rareUltra = "Rare Ultra"
    case uncommon = "Uncommon"
}
