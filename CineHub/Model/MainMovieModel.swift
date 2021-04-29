//
//  MainMovieModel.swift
//  CineHub
//
//  Created by Leena Daryani on 4/20/21.
//

import Foundation
struct MainMovieModel: Codable {
     var results: [MovieDetails]?
 }
 
struct Movie: Codable {
     var categoryName: String?
     var movies: [MovieDetails]?
 }

struct MovieDetails: Codable {
    var title:String?
    var vote_average:Double?
    var poster_path:String?
    var release_date: String?
    var overview: String?
    var id:Double?
 }

struct SingleMovieDetails: Codable {
    var title:String?
    var vote_average:Double?
    var poster_path:String?
    var release_date:String?
    var overview: String?
    var id:Double?
    var genres:[GenresName]?
    var revenue:Double?
    var tagline:String?
    var budget:Double?
    var backdrop_path:String?
    var runtime:Double?
 }

struct GenresName: Codable {
     var id: Double?
     var name: String?
 }

struct VideoResponse: Codable {
     var results: [Video]?
 }

struct Video: Codable {
    var key: String?
}



