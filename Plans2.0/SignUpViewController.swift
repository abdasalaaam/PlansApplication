//
//  SignUpViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 3/24/22.
//

import UIKit

public class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!;
    
    @IBOutlet weak var passwordField: UITextField!;
    
    @IBOutlet weak var emailField: UITextField!;
    
    @IBOutlet weak var phoneNumberField: UITextField!;
    
    @IBOutlet weak var registerButton: UIButton!;
    
    @IBOutlet weak var loginButton: UIButton!;
    
    private let label: UILabel = {
        let label = UILabel();
        label.textColor = .systemRed;
        label.text = "Invalid Sign Up Credentials. \n Make sure your username is unique, and your password is 7 or more characters!";
        return label;
    }();
    private var currentUser = User(fullName: "Alex Pallozzi", userName: "Zandi102", email: "alexanderpallozzi@gmail.com", phone: 9784939211, age: 21, password: "Ozzie123");
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = CGRect.init(x: view.frame.size.width - 1000, y: view.frame.size.height - 200, width: 500, height: 100);

       /* loginButton?.addTarget(self, action: #selector(switchScreen), for: .touchUpInside);
        */
        registerButton?.addTarget(self, action: #selector(register), for: .touchUpInside);
    }
    
    @IBAction func unwindToSignup(_ sender: UIStoryboardSegue) {}
    
    @objc func register () {
        let x = passwordField.text!;
        if(x.count < 7) {
            view.addSubview(label);
            label.frame = CGRect.init(x: view.frame.size.width - 320, y: view.frame.size.height - 200, width: 500, height: 100);
            usernameField.text = "";
            passwordField.text = "";
            emailField.text = "";
            phoneNumberField.text = "";
        }
        else {
            switchScreen();
            usernameField.text = "";
            passwordField.text = "";
            emailField.text = "";
            phoneNumberField.text = "";
            label.frame = CGRect.init(x: view.frame.size.width - 1000, y: view.frame.size.height - 200, width: 500, height: 100);
        }
    }
    
    @objc func giveMeTheTransition() {
        let loginViewController:LoginViewController = LoginViewController()

        self.present(loginViewController, animated: true, completion: nil)
     }
    
    @objc func switchScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MapNav") as? UIViewController {
            self.present(viewController, animated: false, completion: nil);
        }
    }
    func getUser() -> User {
        return self.currentUser
    }
    
    /*@objc func switchScreen() {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }*/
    


}
