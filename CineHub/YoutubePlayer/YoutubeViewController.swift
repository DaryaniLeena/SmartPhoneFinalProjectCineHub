//
//  YoutubeViewController.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var player: YTPlayerView!
    var movieId: Double
    
    init(movieId: Double) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        fetchVideos()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchVideos() {
        NetworkHelper.getVideos(movieId: "\(movieId)") {[weak self] (result: Result<VideoResponse, Error>) in
            switch result {
            case .success(let response):
                if let key = response.results?.first?.key {
                    DispatchQueue.main.async {
                        self?.player.load(withVideoId: key)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
