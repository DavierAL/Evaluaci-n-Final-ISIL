//
//  Movie.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import Foundation

typealias Movies = Movie

struct Movie: Codable {
    let id: Int
    let title: String
    let vote_average: Double
    let poster_path: String?
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case vote_average
        case poster_path
        case overview
    }
}


struct MovieWrapper: Codable {
    let results: [Movie]
}
    
  
    
struct Image: Decodable {
    let url: String
        
    enum CodingKeys: String, CodingKey {
        case url
    }
}
    

        
    enum CodingKeys: String, CodingKey  {
        case heroes = "results"
    }


