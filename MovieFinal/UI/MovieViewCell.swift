//
//  MovieViewCell.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import UIKit


protocol MovieTableViewCellDelegate: AnyObject {
    func TapAddFav(in cell: MovieViewCell)
    
}

class MovieViewCell: UITableViewCell {

    weak var delegate: MovieTableViewCellDelegate?
    var movie: Movie?
  
    @IBOutlet weak var addFav: UIButton!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var rate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addCore(with movie: Movie, isFavorite: Bool) {
        self.movie = movie
        name.text = movie.title
        rate.text = String(format: "%.1f", movie.vote_average)
        
        // Cambiar el icono del botón según si la película es favorita o no
        if isFavorite {
            addFav.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            addFav.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }


    @IBAction func AddFavAct(_ sender: UIButton) {
    }
}
