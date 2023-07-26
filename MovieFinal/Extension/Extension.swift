//
//  Extension.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from url: String){
        
        guard  let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Error: did not receive data")
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error: invalid data")

                return
            }
                
            DispatchQueue.main.async {
                self.image = image
            }
    
        }
        
        task.resume()
        
    }
    
}
