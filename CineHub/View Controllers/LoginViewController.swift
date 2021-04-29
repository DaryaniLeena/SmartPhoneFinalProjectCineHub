//
//  LoginViewController.swift
//  CineHub
//
//  Created by Leena Daryani on 4/16/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpElements() {
        //hide the error button
        errorLabel.alpha = 0
        view.setNeedsLayout()
        view.layoutIfNeeded()
        //style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
//       let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        let categoryVC = CategoryViewController()
        let nav = UINavigationController(rootViewController: categoryVC)
        view.window?.rootViewController = nav
        view.window?.makeKeyAndVisible()
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
      
    
    func validateFields() -> String? {
        
        //check if all fields are filled in
        
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all the fields."
            
        }
     return nil
    }

    @IBAction func loginTapped(_ sender: Any) {
        //validate the text field (all filled)
        
        let error = validateFields()
        
        if error != nil {
            self.showError(error!)
        } else {
        // create clean version of fields
         
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    self.transitionToHome()
                }
        }
        }
        
        
    }
}
