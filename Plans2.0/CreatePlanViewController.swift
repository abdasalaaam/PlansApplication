//
//  CreatePlanViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 3/28/22.
//
import UIKit
import CoreLocation

class CreatePlanViewController: UIViewController {
    //var planLimit = 3;
    var add_success : Bool = false
    
    @IBOutlet weak var planName: UITextField!
    @IBOutlet weak var planAddress: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    @IBOutlet weak var planNotes: UITextView!
    
    @IBOutlet weak var createPlanButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    private let successPlan: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "Plan Created Successfully!"
        return label
    }();
    private let backToMap: UILabel = {
        let label1 = UILabel()
        label1.textColor = .systemGreen
        label1.text = "Press Cancel To Return to Map"
        return label1
    }();
    
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
        
        // create plan in the DB
        let planName1 = self.planName.text!
        let datePicker1 = self.datePicker.date.description;
        let startPicker1 = self.datePicker.date.description;
        let endPicker1 = self.datePicker.date.description;
        let addressName = self.planAddress.text!
        let planNotes1 = self.planNotes.text!
        let longitude : Double = 5.0;
        let latitude : Double = 5.0;
        
        let db = DBManager();
        let url = URL(string: "http://abdasalaam.com/Functions/createPlan.php")!
        let parameters: [String: Any] = [
            "plan_name":planName1,
            // "username":passwordField.text!, This must take the username from the global User class
            "startTime":startPicker1,
            "endTime":endPicker1,
            "date":datePicker1,
            "longitude":longitude,
            "latitude":latitude
        ]
        let message = db.postRequest(url, parameters)
        
        let day : Date = self.datePicker.date
        let dayDifference : TimeInterval = day.timeIntervalSinceNow
        let startTime : Date = self.startTimePicker.date.addingTimeInterval(dayDifference)
        let endTime   : Date = self.endTimePicker.date.addingTimeInterval(dayDifference)
        print("day of plan: \(day.description)")
        print("start time of plan: \(startTime.description) VS \(self.startTimePicker.date.description)")
        print("end time of plan: \(endTime.description)")
        // planToAdd
        let planToAdd = Plan(title: planName.text!, startTime: startTime, endTime: endTime, address: planAddress.text!, notes: planNotes.text!)
        planToAdd.setOwner(newOwner: User.sampleUser) // get the user who is logged on
        // Plan.samplePlanList.append(planToAdd);
        // User.sampleUser.plans.append(planToAdd);      // add to the user whos using
        
        Plan.validate(planToValidate: planToAdd)
        let plan_coord : CLLocationCoordinate2D? = planToAdd._coord ?? nil
        if plan_coord == nil {
            print("Couldn't Add Plan, Check Inputs!")
        } else {
            view.addSubview(successPlan)
            view.addSubview(backToMap)
            successPlan.frame = CGRect.init(x: 110, y: view.frame.size.height - 100, width: view.frame.size.width - 50, height: 50)
            backToMap.frame = CGRect.init(x: 95, y: view.frame.size.height - 75, width: view.frame.size.width - 40, height: 50)
            User.sampleUser.plans.append(planToAdd)
        }// add to the user
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
