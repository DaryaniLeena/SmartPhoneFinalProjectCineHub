//
//  MoviesListViewController.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var searchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var viewModel: MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.reload = {[weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        searchTextField.addTarget(self, action: #selector(MoviesListViewController.textFieldDidChange(_:)), for: .editingChanged)

        
        searchHeightConstraint.constant = viewModel.search ? 50 : 0
        searchContainerView.layer.borderWidth = 1
        searchContainerView.layer.borderColor = UIColor.blue.cgColor
        
        moviesTableView.backgroundColor = UIColor.clear
        moviesTableView.backgroundView = UIImageView(image: UIImage(named: "theater"))
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.searchMovies(search: textField.text ?? "")
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailsVC = MovieDetailsViewController(movieDetails: viewModel.movies[indexPath.row])
//        var detailsVC = SingleMovieViewController(movieDetails: viewModel.movies[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell {
            cell.layer.backgroundColor =  UIColor.clear.cgColor
            cell.contentView.backgroundColor = UIColor.clear
            cell.setupCell(movie: viewModel.movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }    
}
