//
//  PlanDetailViewController.swift
//  Plans2.0
//
//  Created by Muhammed Demirak on 4/16/22.
//

import UIKit

class PlanDetailViewController : UIViewController {
    
    typealias PlanChangeAction = (Plan) -> Void

    private var plan : Plan?
    private var workingPlan : Plan?
    private var dataSource : UITableViewDataSource?
    
    private var planEditAction : PlanChangeAction?
    
    @IBOutlet weak var planTableView : UITableView!
    
    func configure(with plan : Plan, editAction : PlanChangeAction? = nil) {
        self.plan = plan
        self.workingPlan = plan
        self.planEditAction = editAction
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planTableView.delegate = self
        planTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController,
           !navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
    
    
}

extension PlanDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0;
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planDetailCell = tableView.dequeueReusableCell(withIdentifier: "plan_cell", for: indexPath)
        
        
        return planDetailCell
    }
}
