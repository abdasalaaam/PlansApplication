//
//  CreatePlanViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 3/28/22.
//
import UIKit

class CreatePlanViewController: UIViewController {
    //var planLimit = 3;
    
    @IBOutlet weak var planName: UITextField!
    @IBOutlet weak var planAddress: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    @IBOutlet weak var planNotes: UITextView!
    
    @IBOutlet weak var createPlanButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        //datePicker.setValue(UIColor.systemOrange, forKeyPath: "backgroundColor")
        startTimePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        endTimePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        datePicker.overrideUserInterfaceStyle = .light
        createPlanButton?.addTarget(self, action: #selector(createPlan), for: .touchUpInside);
    }
    
    @objc func createPlan() {
        let planName1 = self.planName.text!
        let datePicker1 = self.datePicker.date.description;
        let startPicker1 = self.datePicker.date.description;
        let addressName = self.planAddress.text!
        let planNotes1 = self.planNotes.text!
        Plan.samplePlanList.append(Plan(title: planName1, date: datePicker1, startTime1: startPicker1, endTime1: self.endTimePicker.date.description, address: addressName, notes: planNotes1, owner: User.sampleUser))
        
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
