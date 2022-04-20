//

//  CreatePlanViewController.swift

//  Plans2.0

//

//  Created by Alex Pallozzi on 3/28/22.

//

import UIKit

import CoreLocation

class CreatePlanViewController: UIViewController {
    // FIELDS
    let activeUser : User = User.sampleUser // represents the active user logged in, who uses the view controller
    var add_success : Bool = false          // represents if the plan has been added to the list
    // IBOUTLETS
    @IBOutlet weak var planName: UITextField!
    
    @IBOutlet weak var planAddress: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    @IBOutlet weak var planNotes: UITextView!
    
    @IBOutlet weak var createPlanButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    private var isAddressInvalid = false
    private var isTimeInvalid = false
    private var isDateInvalid = false
    private var isInvalid = false
    private var planCreated = false
    // RESPONSE TO USER INPUTS LABEL
    private let successPlan: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "Plan Created Successfully!"
        return label
    }();

    private let backToMap: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "Press Cancel To Return to Map"
        return label
    }();

    private let failPlan: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "Plan Creation Failed"
        return label
    }();

    private let checkAddressInput: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        label.adjustsFontSizeToFitWidth = true;
        label.text = "Check address, use format: Address, City, State, Zip"
        return label
    }();

    private let checkTimeInput: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        label.adjustsFontSizeToFitWidth = true;
        label.text = "Invalid Time/Date. Make sure it hasn't yet happened!"
        return label
    }();
    // VIEWDIDLOAD OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        //datePicker.setValue(UIColor.systemOrange, forKeyPath: "backgroundColor")
        startTimePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        endTimePicker.setValue(UIColor.systemOrange, forKeyPath: "textColor")
        datePicker.overrideUserInterfaceStyle = .light
        createPlanButton?.addTarget(self, action: #selector(createPlan), for: .touchUpInside);
        cancelButton?.addTarget(self, action: #selector(cancel), for: .touchUpInside);

    }
    // the plan is valid, return a plan
    // for a plan to be valid, three things must be true:
    // 1 - address/coordinate binding of address
    // 2 - the start time must be greater than the current date
    // 3 - the end time must be greater than the start time
    // if it isn't, return nil
    // TO PROPERLY ADD A PLAN, ALL FUNCTIONALITIES TO BE CHANGED ABOUT ADDING
    // MUST BE DONE WITHIN THIS METHOD

    private func validate(planToValidate : Plan) {
        // the return value could either be a plan or nil value
        // validate the start time and end time of the plan, to make sure that start time is > current date, and end time is > starttime
        if planToValidate.day.compare(Date()).rawValue > 0 && planToValidate.endTime.compare(planToValidate.startTime).rawValue > 0 {
            // validate the address string input of the plan
            // sample address: 11317 Bellflower Road, Cleveland, OH 44106
            valid_coord(plan: planToValidate) { (complete, error) in
                if error == nil {
                    // set up the plan to be a valid plan
                    planToValidate._coord = CLLocationCoordinate2D(latitude: complete.latitude, longitude: complete.longitude)
                    planToValidate.validated = true;
                    //planToValidate.owner = self.activeUser
                    self.activeUser.plans.append(planToValidate)
                    self.add_success = true
                    
                    // print success response to the user
                    self.view.addSubview(self.successPlan)
                    self.view.addSubview(self.backToMap)
                    self.planCreated = true;
                    if(self.isInvalid == true) {
                        self.failPlan.removeFromSuperview()
                        self.isInvalid = false;
                        //self.isTimeInvalid = false
                    }
                    if(self.isTimeInvalid == true) {
                        self.checkTimeInput.removeFromSuperview()
                    }
                    if(self.isAddressInvalid == true) {
                        self.checkAddressInput.removeFromSuperview()
                        //self.isAddressInvalid = false
                    }
                    self.successPlan.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 100, width: self.view.bounds.width, height: 50);
                    self.successPlan.textAlignment = .center;
                    self.backToMap.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 75, width: self.view.bounds.width, height: 50)
                    self.backToMap.textAlignment = .center


                    // print success details to console
                    print("plan validated? = \(planToValidate.validated.description), so plan has been added")
                    print("plan address: \(planToValidate.address ?? "niladdress")")
                    print("plan coordinates: \(planToValidate._coord?.latitude.description ?? "invalidlat"), \(planToValidate._coord?.longitude.description ?? "invalid long")")
                    print("plan day: \(Plan.dayText(planToValidate.startTime))")
                    print("time: \(Plan.timeText(planToValidate.startTime)) - \(Plan.timeText(planToValidate.endTime))")
                }
                else {
                    self.isAddressInvalid = true
                    self.isInvalid = true
                    self.view.addSubview(self.failPlan)
                    self.view.addSubview(self.checkAddressInput)
                    if(self.isTimeInvalid == true) {
                        self.checkTimeInput.removeFromSuperview()
                        self.isTimeInvalid = false;
                    }
                    self.failPlan.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 100, width: self.view.bounds.width, height: 50);
                    self.failPlan.textAlignment = .center;
                    self.checkAddressInput.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 75, width: self.view.bounds.width, height: 50)
                    self.checkAddressInput.textAlignment = .center
                    // print error details to console
                    print("error: invalid coordinates") // throw error
                    print("plan address: \(planToValidate.address ?? "niladdress")")
                    print("plan coordinates: \(planToValidate._coord?.latitude.description ?? "invalidlat"), \(planToValidate._coord?.longitude.description ?? "invalidlong")")
                }
            }
        }
        else {
            self.isTimeInvalid = true
            self.isInvalid = true
            self.view.addSubview(self.failPlan)
            self.view.addSubview(self.checkTimeInput)
            if(self.isAddressInvalid == true) {
                self.checkAddressInput.removeFromSuperview();
                self.isAddressInvalid = false;
            }
            //self.failPlan.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width - 50, height: 50)
            self.failPlan.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 100, width: self.view.bounds.width, height: 50);
            self.failPlan.textAlignment = .center;
            self.checkTimeInput.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 75, width: self.view.bounds.width, height: 50)
            self.checkTimeInput.textAlignment = .center
            // print error details to console
            print("error: invalid start time and/or end time") // throw error
            print("plan day: \(Plan.dayText(planToValidate.startTime))")
            print("time: \(Plan.timeText(planToValidate.startTime)) - \(Plan.timeText(planToValidate.endTime))")
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
    // CREATEPLANBUTTONACTION

    @objc func cancel() {
        self.add_success = false;
        print(add_success);
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
        if(add_success == false) {
            let day : Date = self.datePicker.date
            let dayDifference : TimeInterval = day.timeIntervalSince(Date())
            let startTime : Date = self.startTimePicker.date.addingTimeInterval(dayDifference)
            let endTime   : Date = self.endTimePicker.date.addingTimeInterval(dayDifference)
            let planToAdd = Plan(title: planName.text!, startTime: startTime, endTime: endTime, address: planAddress.text!, notes: planNotes.text!, owner: User(userName: "", password: "", fullName: "Me"))
            //planToAdd.setOwner(newOwner: User.sampleUser) // get the user who is logged on
            validate(planToValidate: planToAdd) // handle the validation and plan adding
        }           // validation implemented this way due to the geocoder completion handler,
                    // no other known way to validate the address
    }
}
