//
//  MovieService.swift
//  MovieFinal
//
//  Created by user213622 on 7/22/23.
//

import Foundation

protocol MovieServiceProtocol {
    func getMovies(_ url: String, completion: @escaping (_ success: Bool, _ data: Movies?, _ error: String?)-> () )
    
}

class MovieService: MovieServiceProtocol{
    func getMovies(_ url: String, completion: @escaping (Bool, Movies?, String?) -> ()) {
        HttpRequest().GET(url: url) { success, data in
            if success{
                do{
                    let wrapper = try JSONDecoder().decode(MovieWrapper.self, from: data!)
                    let movies = wrapper.results
                    completion(true,  ,nil)
                }catch(let error){
                    completion(false, nil,  error.localizedDescription)
                }
            }else{
                completion(false,nil,"ERROR: Movie GET request failed")
            }
        }
    }
    

}
