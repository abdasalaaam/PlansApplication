//
//  ViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 2/23/22.
//

import UIKit

class ViewController: UIViewController {

  //  private let imageView: UIImageView = {
     //   let imageView = UIImageView()
      //  imageView.contentMode = .scaleAspectFill
      //  imageView.backgroundColor = .white
      //  return imageView
        
   // }()
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userDescriptionField: UITextView!
    
    @IBOutlet weak var saveChangesButton: UIButton? = {
        let saveChangesButton = UIButton();
        saveChangesButton.backgroundColor = .white;
        return saveChangesButton;
    }()
    
    
    private let button: UIButton = {
        let button = UIButton();
        button.backgroundColor = .red;
        return button;
    }()
    override func viewDidLoad() {
        super.viewDidLoad();
        saveChangesButton?.addTarget(self, action: #selector(buttonTap), for: .touchUpInside);
        saveChangesButton!.frame = CGRect.init(x: 0, y: view.frame.size.height - 250, width: self.view.bounds.width, height: 100);
        userTextField.text = User.sampleUser.userName
        userPasswordField.text = User.sampleUser.password
        userEmailField.text = User.sampleUser.fullName;
       // userTextField.frame = CGRect.init(x: 0, y: view.frame.size.height - 300, width: self.view.bounds.width, height: 100);
        //userPasswordField.frame = CGRect.init(x: 0, y: view.frame.size.height - 300, width: self.view.bounds.width, height: 100);
        
        //saveChangesButton!.frame
        
        
    }
    @objc func buttonTap() {
        User.sampleUser.fullName = userEmailField.text!;
    }
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue) {}
    

}

