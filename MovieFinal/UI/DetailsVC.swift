//
//  DetailsVC.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import UIKit

class DetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsViewCell
        let actor = actors[indexPath.row]
        cell.ActorDetails(with: actor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Aquí puedes especificar la altura de las celdas
        return 100
    }
  
    
    var movieId: Int?
    var actors: [Actor] = []
    var movie: Movie?

    @IBOutlet var castTable: UITableView!
    @IBOutlet var posterDetails: UIImageView!
    @IBOutlet var overviewText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castTable.dataSource = self
        castTable.delegate = self
        
        if let movie = movie {
               if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")") {
                   downloadImage(from: url) { [weak self] image, error in
                       if let error = error {
                           print("Error image: \(error)")
                           return
                       }
                       
                       DispatchQueue.main.async {
                           self?.posterDetails.image = image
                       }
                   }
               }
               overviewText.text = movie.overview
            
               navigationItem.title = movie.title
            
               LoadActors(movieId: Int(movie.id)) { [weak self] (result: Result<[Actor], Error>) in
                   switch result {
                   case .success(let actors):
                       self?.actors = actors
                       DispatchQueue.main.async {
                           self?.castTable.reloadData()
                       }
                   case .failure(let error):
                       print("Error fetching actors: \(error)")
                   }
               }
           }
        
    }
    
    func downloadImage(from url: URL?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = url else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                completion(nil, nil)
                return
            }
            
            // Llamamos a la función de finalización con la imagen descargada
            completion(image, nil)
        }.resume()
    }

}
