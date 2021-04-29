//
//  NetworkHelper.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation

class NetworkHelper {
    class func getMovies<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/" + endpoint + "?api_key=ea64de9bddd08b946b34a41ba227ce72&language=en-US&page=1"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(error!))
                }
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let json = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    class func getMovieDetails<T: Codable>(id: String, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString =  "https://api.themoviedb.org/3/movie/" +
            id +
            "?api_key=ea64de9bddd08b946b34a41ba227ce72&language=en-US&page=1"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(error!))
                }
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let json = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    class func searchMovies<T: Codable>(search: String, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=ea64de9bddd08b946b34a41ba227ce72&language=en-US&query=" +
            search +
            "&page=1&include_adult=false"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(error!))
                }
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let json = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    class func getVideos<T: Codable>(movieId: String, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/" + movieId + "/videos?api_key=ea64de9bddd08b946b34a41ba227ce72&language=en-US&page=1"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(error!))
                }
                if let data = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let object = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(object))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
