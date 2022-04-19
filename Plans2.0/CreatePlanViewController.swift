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
    let activeUser : User = User.sampleUser
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
    
    // the plan is valid, return a plan
    // for a plan to be valid, three things must be true:
    // 1 - address/coordinate binding of address
    // 2 - the start time must be greater than the current date
    // 3 - the end time must be greater than the start time
    // if it isn't, return nil
    func validate(planToValidate : Plan) {
        // the return value could either be a plan or nil value
        // validate the start time and end time of the plan, to make sure that start time is > current date, and end time is > starttime, implemented using DeMorgan's Laws
        if planToValidate.startTime.compare(Date()).rawValue > 0 && planToValidate.endTime.compare(planToValidate.startTime).rawValue > 0 {
            valid_coord(plan: planToValidate) { (complete, error) in
                if error == nil {
                    planToValidate._coord = CLLocationCoordinate2D(latitude: complete.latitude, longitude: complete.longitude)
                    planToValidate.validated = true;
                    print("Coordinates have been set")
                    print("plan is valid")
                    print("validated? : \(planToValidate.validated.description)")
                    self.add_success = true
                    self.view.addSubview(self.successPlan)
                    self.view.addSubview(self.backToMap)
                    self.successPlan.frame = CGRect.init(x: 110, y: self.view.frame.size.height - 100, width: self.view.frame.size.width - 50, height: 50)
                    self.backToMap.frame = CGRect.init(x: 95, y: self.view.frame.size.height - 75, width: self.view.frame.size.width - 40, height: 50)
                
                    self.activeUser.plans.append(planToValidate)
                    print("plan is valid, so plan has been added")
                }
                else {
                    print("error: invalid coordinates") // throw error Plan Creation Failed
                }
            }
        }
        else {
            // validate the coordinates of the string address
            print("error: invalid start time and/or end time") // throw error
        }
    }
    
    // gets the coordinates of the address
    private func valid_coord(plan: Plan, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(plan.address) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
           }
       }
    
    @objc func createPlan() {
        // create plan in the DB
        /*
        let planName1 = self.planName.text!
        let datePicker1 = self.datePicker.date.description;
        let startPicker1 = self.datePicker.date.description;
        let endPicker1 = self.datePicker.date.description;
        let addressName = self.planAddress.text!
        let planNotes1 = self.planNotes.text!
        let longitude : Double = 5.0;
        let latitude : Double = 5.0;
        */
        
       /*
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
        */
        
        let day : Date = self.datePicker.date
        let dayDifference : TimeInterval = day.timeIntervalSince(Date())
        let startTime : Date = self.startTimePicker.date.addingTimeInterval(dayDifference)
        let endTime   : Date = self.endTimePicker.date.addingTimeInterval(dayDifference)
        
        let planToAdd = Plan(title: planName.text!, startTime: startTime, endTime: endTime, address: planAddress.text!, notes: planNotes.text!)
        planToAdd.setOwner(newOwner: User.sampleUser) // get the user who is logged on
        // 11317 Bellflower Road, Cleveland, OH 44106
        validate(planToValidate: planToAdd)
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
