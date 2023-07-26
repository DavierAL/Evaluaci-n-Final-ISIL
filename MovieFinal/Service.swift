//
//  Service.swift
//  MovieFinal
//
//  Created by user213622 on 7/25/23.
//

import Foundation


func LoadActors(movieId: Int, completion: @escaping (Result<[Actor], Error>) -> Void) {
    let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=3cae426b920b29ed2fb1c0749f258325"
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "", code: 100, userInfo: nil)))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let actorWrapper = try decoder.decode(ActorWrapper.self, from: data)
                completion(.success(actorWrapper.cast))
            } catch {
                completion(.failure(error))
            }
        }
    }.resume()
}
