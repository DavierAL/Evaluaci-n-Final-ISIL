//
//  DetailsViewCell.swift
//  MovieFinal
//
//  Created by user213622 on 7/24/23.
//

import UIKit

class DetailsViewCell: UITableViewCell {
    
    func ActorDetails(with actor: Actor) {
        actorName.text = actor.name
        fakeName.text = actor.character
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(actor.imgPath ?? "")") {
            downloadImage(from: url) { [weak self] image, error in
                if let error = error {
                    print("Error image: \(error)")
                    self?.actorImg.image = UIImage (named: "error.svg")// Imagen predeterminada en caso de error
                    return
                }
                DispatchQueue.main.async {
                    self?.actorImg.image = image
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error) // Se llama a la función de finalización con el error
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image, nil) // Se llama a la función de finalización con la imagen descargada
            } else {
                completion(nil, nil) // Si no se pudo crear la imagen, se llama a la función de finalización con nil
            }
        }.resume()
    }

    
    @IBOutlet var actorImg: UIImageView!
    @IBOutlet var actorName: UILabel!
    @IBOutlet var fakeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
