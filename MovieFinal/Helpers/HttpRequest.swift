//
//  HttpRequest.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import Foundation

class HttpRequest {
    
func GET(url: String, completion: @escaping (Bool, Data?)->()) {
    guard let url = URL(string: url) else {
        print("Error: invalid URL")
        completion(false, nil)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        
        guard error == nil else {
            print("Error: problem calling GET")
            print("Error: \(error!)")
            completion(false, nil)
            return
        }
        
        guard let data = data else {
            print("Error: data not found")
            completion(false, nil)
            return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Error: HTTP request failed")
            completion(false, nil)
            return
        }
        completion (true, data)
        
    }
    task.resume()
    }
}
