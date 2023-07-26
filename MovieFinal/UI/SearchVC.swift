//
//  ViewController.swift
//  MovieFinal
//
//  Created by user213622 on 7/20/23.
//

import UIKit

class SearchVC:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieViewCell
            let movie = items[indexPath.row]
            cell.name.text = movie.title
           
            cell.rate.text = "\(movie.vote_average)";
            if let posterPath = movie.poster_path {
                cell.poster.loadImage(from: "https://image.tmdb.org/t/p/w500\(posterPath)")
            } else {
                cell.poster.image = nil
            }
            return cell
        }

    
    @IBOutlet var tableMovies: UITableView!
    var items = [Movie]()
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMovies.delegate = self
        tableMovies.dataSource = self

    }
    
    @IBAction func SearchButton(_ sender: UIButton) {
        guard let searchTextName = txtName.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            print("Error: invalid Movie")
            return
        }
      SearchMovie(searchTextName)
    }
    
    func SearchMovie(_ movie: String) {
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=3cae426b920b29ed2fb1c0749f258325&query=\(movie)") else {
                print("Error: Invalid URL")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("Error: \(error!)")
                    return
                }
                guard let data = data else {
                    print("Error: Invalid data")
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Error: HTTP request failed")
                    return
                }

                do {
                    let movieWrapper = try JSONDecoder().decode(MovieWrapper.self, from: data)
                    self.items = movieWrapper.results

                    DispatchQueue.main.async {
                        self.tableMovies.reloadData()
                    }
                } catch (let error) {
                    print("Error: \(error)")
                }
            }
            task.resume()
        }
    


    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next",
            let destination = segue.destination as? DetailsVC,
            let indexPath = tableMovies.indexPathForSelectedRow {
            destination.movie = items[indexPath.row]
        }
    }

}

