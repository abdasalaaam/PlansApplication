//
//  PlanDetailViewController.swift
//  Plans2.0
//
//  Created by Muhammed Demirak on 4/16/22.
//

import UIKit

class PlanDetailViewController : UIViewController {
    
    typealias PlanChangeAction = (Plan) -> Void
    private var plan : Plan = Plan(title: "", startTime: Date(), endTime: Date(), address: "", notes: "")
    private var workingPlan : Plan?
    private var dataSource : UITableViewDataSource?
    
    private var planEditAction : PlanChangeAction?
    
    @IBOutlet weak var planTitleField: UITextField!
    
    @IBOutlet weak var planAddressField: UITextField!
    
    @IBOutlet weak var dayPicker: UIDatePicker!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    @IBOutlet weak var notesView: UITextView!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    func configure(with plan : Plan, editAction : PlanChangeAction? = nil) {
        self.plan = plan
        self.workingPlan = plan
        self.planEditAction = editAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planTitleField.text = plan.title
        planTitleField.allowsEditingTextAttributes = false
        planAddressField.text = plan.address
        planAddressField.allowsEditingTextAttributes = false
        dayPicker.date = plan.startTime
        dayPicker.endEditing(true)
        startTimePicker.date = plan.startTime
        startTimePicker.endEditing(true)
        endTimePicker.date = plan.endTime
        endTimePicker.endEditing(true)
        notesView.text = plan.notes
        notesView.allowsEditingTextAttributes = false
    }
    
    @objc func backTap() {
        //set values for signup to null;
    }
}
