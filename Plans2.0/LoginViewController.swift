//
//  LoginViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 3/24/22. 
//
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLogin: UITextField!
    
    @IBOutlet weak var passwordLogin: UITextField!
    
    @IBOutlet weak var emailLogin: UITextField!
    
    @IBOutlet weak var phoneNumberLogin: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    private var loggedIn = false;
    
    private let label: UILabel = {
        let label = UILabel();
        label.textColor = .systemRed;
        label.text = "Invalid Credentials";
        return label;
    }();
    
    private var currentUser = User(fullName: "Alex Pallozzi", userName: "Zandi102", email: "alexanderpallozzi@gmail.com", phone: 9784939211, age: 21, password: "Hi123");
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton?.addTarget(self, action: #selector(login), for: .touchUpInside)
        /*if(failedLogin == true) {
            view.addSubview(label);
            label.frame = CGRect.init(x: 20, y: view.frame.size.height - 100, width: view.frame.size.width - 40, height: 50);
        }*/
    }
    
    @objc func login (){
        if (currentUser.userName == self.usernameLogin.text && currentUser.password == passwordLogin.text && currentUser.email == emailLogin.text) {
            switchScreen();
            usernameLogin.text = "";
            passwordLogin.text = "";
            emailLogin.text = "";
            phoneNumberLogin.text = "";
            label.frame = CGRect.init(x: view.frame.size.width - 1000, y: view.frame.size.height - 300, width: view.frame.size.width - 40, height: 50);
        }
        
        else {
            view.addSubview(label);
            label.frame = CGRect.init(x: view.frame.size.width - 285, y: view.frame.size.height - 350, width: view.frame.size.width - 40, height: 50);
            usernameLogin.text = "";
            passwordLogin.text = "";
            emailLogin.text = "";
            phoneNumberLogin.text = "";
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //let destVC = segue.destination as! SignUpViewController;
    }
    
    @objc func switchScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        if let viewController =  mainStoryboard.instantiateViewController(withIdentifier: "MapNav") as? UIViewController {
            self.present(viewController, animated: false, completion: nil);
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
