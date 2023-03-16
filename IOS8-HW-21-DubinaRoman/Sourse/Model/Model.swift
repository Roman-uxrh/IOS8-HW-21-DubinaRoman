//
//  Model.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 15.03.2023.
//

import UIKit

struct AnswerMarvelService: Codable {
    var data: CharactersMarvel
}

struct CharactersMarvel: Codable {
    var count: Int?
    var results: [CharacterMarvel]
}

struct CharacterMarvel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Image?
    var comics: ComicsList?
}

struct Image: Codable {
    var path: String?
    var format: String?

    enum CodingKeys: String, CodingKey {
        case format = "extension"
        case path
    }
}

struct ComicsList: Codable {
    var available: Int?
    var items: [Comic]?
}

struct Comic: Codable {
    var name: String? 
}
