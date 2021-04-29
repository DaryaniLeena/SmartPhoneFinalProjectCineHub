//
//  CategoryViewController.swift
//  CineHub
//
//  Created by Leena Daryani on 28/04/21.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController {
    @IBAction func playingButtonTapped(_ sender: Any) {
        let vm = MoviesViewModel(category: .playing)
        let vc = MoviesListViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func popularButtonTapped(_ sender: Any) {
        let vm = MoviesViewModel(category: .popular)
        let vc = MoviesListViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func topRatedButtonTapped(_ sender: Any) {
        let vm = MoviesViewModel(category: .topRated)
        let vc = MoviesListViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func upcomingButtonTapped(_ sender: Any) {
        let vm = MoviesViewModel(category: .upcoming, search: true)
        let vc = MoviesListViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        let window = UIApplication.shared.windows.first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "initialNav")
        window?.rootViewController = vc
    }
    
}
