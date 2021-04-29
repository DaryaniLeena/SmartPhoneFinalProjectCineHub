//
//  MoviesViewModel.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

enum MoviesCategory {
    case playing
    case popular
    case topRated
    case upcoming
    
    var path: String {
        switch self {
        case .playing:
            return "now_playing"
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}

class MoviesViewModel {
    var search: Bool = false
    var reload: (() -> Void)?
    var category: MoviesCategory
    var movies: [MovieDetails] = [] {
        didSet {
            reload?()
        }
    }
    
    init(category: MoviesCategory, search: Bool = false) {
        self.category = category
        self.search = search
        fetchMovies()
    }
    
    func fetchMovies() {
        NetworkHelper.getMovies(endpoint: category.path) { (result: Result<MainMovieModel, Error>) in
            switch result {
            case .success(let response):
                self.movies = response.results ?? []
            case .failure(let error):
                self.movies = []
            }
        }
    }
    
    func searchMovies(search: String) {
        NetworkHelper.searchMovies(search: search) { (result: Result<MainMovieModel, Error>) in
            switch result {
            case .success(let response):
                self.movies = response.results ?? []
            case .failure(let error):
                self.movies = []
            }
        }
    }
}
