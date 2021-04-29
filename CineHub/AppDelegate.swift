//
//  AppDelegate.swift
//  CineHub
//
//  Created by Leena Daryani on 4/16/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            let categoryVC = CategoryViewController()
            let nav = UINavigationController(rootViewController: categoryVC)
            window?.rootViewController = nav
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "initialNav")
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
        return true
    }
}

