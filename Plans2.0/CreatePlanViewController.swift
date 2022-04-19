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
        let planName1 = self.planName.text!
        let datePicker1 = self.datePicker.date.description;
        let startPicker1 = self.datePicker.date.description;
        let endPicker1 = self.datePicker.date.description;
        let addressName = self.planAddress.text!
        let planNotes1 = self.planNotes.text!
        let longitude : Double = 5.0;
        let latitude : Double = 5.0;
        
      /*  let db = DBManager();
        let url = URL(string: "http://abdasalaam.com/Functions/createPlan.php")!
        let parameters: [String: Any] = [
            "plan_name":planName1,
            // "username":passwordField.text!, This must take the username from the global User class
            "startTime":startPicker1,
            "endTime":endPicker1,
            "date":datePicker1,
            "longitude":longitude,
            "latitude":latitude*/
        
        //let message = db.postRequest(url, parameters)
        
        let planToAdd = Plan(title: planName1, date:  Plan.dayText(datePicker.date), startTime1: Plan.timeText(startTimePicker.date), endTime1: Plan.timeText(endTimePicker.date), address: addressName, notes: planNotes1, owner: User.sampleUser);
        
        Plan.samplePlanList.append(planToAdd);
        view.addSubview(successPlan);
        view.addSubview(backToMap);
        successPlan.frame = CGRect.init(x: 110, y: view.frame.size.height - 100, width: view.frame.size.width - 50, height: 50);
        backToMap.frame = CGRect.init(x: 95, y: view.frame.size.height - 75, width: view.frame.size.width - 40, height: 50);
        if Plan.validate(plan: planToAdd) == nil {
            print("Invalid Address or Date/time");
        }
        else {
            User.sampleUser.addPlan(Plan(title: planName1, date:  Plan.dayText(datePicker.date), startTime1: Plan.timeText(startTimePicker.date), endTime1: Plan.timeText(endTimePicker.date), address: addressName, notes: planNotes1, owner: User.sampleUser));
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
