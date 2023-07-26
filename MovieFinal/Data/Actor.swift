//
//  Actor.swift
//  MovieFinal
//
//  Created by user213622 on 7/25/23.
//

import Foundation

struct Actor: Codable {
    let adult: Bool
    let id: Int
    let name: String
    let popularity: Double
    let imgPath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case adult, id, name, popularity, character
        case imgPath = "profile_path"
    }
}

struct ActorWrapper: Codable {
    let cast: [Actor]
}
