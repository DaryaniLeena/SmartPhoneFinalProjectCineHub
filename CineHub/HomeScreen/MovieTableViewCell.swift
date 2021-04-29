//
//  MovieTableViewCell.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
//  @IBOutlet weak var movieReleaseLabel: UILabel!
    
    @IBOutlet weak var voteAverageView: VoteAverageView!
    
    
    func setupCell(movie: MovieDetails) {
        if let poasterPath = movie.poster_path {
            let url = "https://image.tmdb.org/t/p/w500" + poasterPath
            movieImageView.imageFromServer(urlString: url)
        }
        movieTitleLabel.text = movie.title
//        movieReleaseLabel.text = movie.release_date
        voteAverageView.voteValue = movie.vote_average
    }
}
