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
        //view.backgroundColor = .systemOrange;
        //profilePicture.frame = CGRect(x: 30, y: 150, width: 100, height: 100)
        saveChangesButton?.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
    }
    @objc func buttonTap() {
        //put all information into database
    }
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue) {}
    

}

