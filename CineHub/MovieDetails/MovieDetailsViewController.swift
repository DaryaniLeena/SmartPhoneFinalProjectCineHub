//
//  MovieDetailsViewController.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDetails: MovieDetails
    var singleMovieDetail: SingleMovieDetails?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var playTrailerButton: UIButton!
   
    @IBOutlet weak var vSpinnerLoad: UIView!
    @IBOutlet weak var overviewTextField: UITextView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateText: UILabel!
    @IBOutlet weak var genresText: UILabel!
    @IBOutlet weak var tagline: UILabel!
 
    @IBOutlet weak var moviePoasterImageView: UIImageView!
    
    @IBOutlet weak var movieVotes: VoteAverageView!
    
    init(movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
        super.init(nibName: nil, bundle: nil)
       
       
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
//        spinner.startAnimating()
//        self.showSpinner(onView: self.view)
        fetchMovieDetails()
        self.view.backgroundColor = UIColor.black
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//            backgroundImage.image = UIImage(named: "theater")
//            backgroundImage.contentMode = .scaleAspectFill
//            self.view.insertSubview(backgroundImage, at: 0)
        tagline.textColor = UIColor.white
        genresText.textColor = UIColor.white
        overviewTextField.textColor = UIColor.white
                releaseDateText.textColor = UIColor.white
        durationLabel.textColor = UIColor.white
        budgetLabel.textColor = UIColor.white
//        PlayButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
//        PlayButton.setTitle("Play Trailer", for: .normal)
//        if let poasterPath = singleMovieDetail?.backdrop_path {
//            let url = "https://image.tmdb.org/t/p/w500" + poasterPath
//            moviePoasterImageView.imageFromServer(urlString: url)
//        }
//        titleLabel.text = singleMovieDetail?.title ?? ""
//        tagline.text = singleMovieDetail?.tagline ?? ""
//        genresText.text = singleMovieDetail?.genres?[0].name ?? ""
//        releaseDateText.text = singleMovieDetail?.release_date ?? ""
//        movieVotes.voteValue = singleMovieDetail?.vote_average ?? 0
//        overviewTextField.text = singleMovieDetail?.overview ?? ""
//        if let value = singleMovieDetail?.runtime {
//
//
//
//            let tuple = minutesToHoursAndMinutes(Int(value))
//
//
//            durationLabel.text = String("\(tuple.hours)h  \(tuple.leftMinutes)m")
//        } else {
//            durationLabel.text = ""
//        }
//
//
//
//
//        if let value = singleMovieDetail?.revenue {
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
//
//            budgetLabel.text =  String("$\(formattedNumber!)")
//        } else {
//            budgetLabel.text = ""
//        }
        
    }
    func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    func fetchMovieDetails() {
        
        NetworkHelper.getMovieDetails(id: String(movieDetails.id!)) {
            (result: Result<SingleMovieDetails, Error>) in
//            self.spinner.stopAnimating()
            
            switch result {
            case .success(let response):
//                self.removeSpinner()
                DispatchQueue.main.async {
                    self.singleMovieDetail = response
                    if let poasterPath = self.singleMovieDetail?.backdrop_path {
                        let url = "https://image.tmdb.org/t/p/w500" + poasterPath
                        self.moviePoasterImageView.imageFromServer(urlString: url)
                    }
                    self.titleLabel.text = self.singleMovieDetail?.title ?? ""
                    self.tagline.text = self.singleMovieDetail?.tagline ?? ""
                    self.genresText.text = self.singleMovieDetail?.genres?[0].name ?? ""
                    self.releaseDateText.text = self.singleMovieDetail?.release_date ?? ""
                    self.movieVotes.voteValue = self.singleMovieDetail?.vote_average ?? 0
                    self.overviewTextField.text = (self.singleMovieDetail?.overview ?? "")
                    if let value = self.singleMovieDetail?.runtime {
                        
                        

                        let tuple = self.minutesToHoursAndMinutes(Int(value))
                        
                        
                        self.durationLabel.text = String("\(tuple.hours)h  \(tuple.leftMinutes)m")
                    } else {
                        self.durationLabel.text = ""
                    }
                    
                   
                   
                    
                    if let value = self.singleMovieDetail?.revenue {
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        let formattedNumber = numberFormatter.string(from: NSNumber(value:value))
                        
                        self.budgetLabel.text =  String("$\(formattedNumber!)")
                    } else {
                        self.budgetLabel.text = ""
                    }
                }
              
            case .failure(let error):
                self.singleMovieDetail = nil
            }
        }
    }
    
    @IBAction func PlayTrailerClickMethod(_ sender: Any) {
        if let id = movieDetails.id {
            let ytController = YoutubeViewController(movieId: id)
            navigationController?.pushViewController(ytController, animated: true)
        }
    }
    func showSpinner(onView : UIView) {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            vSpinnerLoad = spinnerView
        }
        
        func removeSpinner() {
            DispatchQueue.main.async {
                self.vSpinnerLoad?.removeFromSuperview()
                self.vSpinnerLoad = nil
            }
        }
    }
    

