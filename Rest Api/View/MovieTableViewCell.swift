//
//  MovieTableViewCell.swift
//  Rest Api
//
//  Created by Babek Gadirli on 15.11.21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    
    @IBOutlet weak var movieDate: UILabel!
    
    
    @IBOutlet weak var movieBio: UILabel!
    
    @IBOutlet weak var movieRate: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        self.movieTitle.text = title
        self.movieDate.text = convertDateFormater(releaseDate)
        guard let rate = rating else {return}
        self.movieRate.text = String(rate)
        self.movieBio.text = overview
        
        guard let posterString = poster else {return}
            urlString = "https://image.tmdb.org/t/p/w300" + posterString
            
            guard let posterImageUrl = URL(string: urlString) else {
                self.moviePoster.image = UIImage(named: "noImage")
                return
            }
        
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageUrl)
    }
    
    func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }

        }.resume()
        
    }
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    
}
