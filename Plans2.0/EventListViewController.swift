//
//  EventListViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 3/24/22.
//

import UIKit

class EventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredPlans = [Plan]();
    //var planList = Plan.samplePlanList
    //var plans = ["Pick Up Basketball by , Date: 4/14/2021. Time: 4:21. Address: 11 Tuttle Drive. User: ajp236", "Pick Up Soccer, Date: 4/14/2021. Time: 4:54. Address: 23 Pico Ave. User: ass112", "Birthday Party, Date: 4/14/2021. Time: 4:21. User: zach324", "Birthday Party, Date: 4/14/2021. Time: 10:56. User: joey243"];
    var searchBarIsFull = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        searchBar.delegate = self;
        searchBar.searchTextField.textColor = .orange

    }
    
    func filterContentForSearchText(searchText: String) {
        filteredPlans = Plan.samplePlanList.filter({(plan: Plan) -> Bool in
            return plan.address.lowercased().contains(searchText.lowercased()) || plan.owner.fullName.lowercased().contains(searchText.lowercased()) || plan.owner.userName.lowercased().contains(searchText.lowercased()) || plan.title.lowercased().contains(searchText.lowercased()) || plan.date.lowercased().contains(searchText.lowercased());
        });
        tableView.reloadData();
    }
    
    func isSearchBarEmpty() -> Bool {
        if(searchBar.text! != "") {
            //print("search bar full");
            return false;
        }
        //print("search bar empty");
        return true;
        //return searchBar.text?.isEmpty ?? true;
    }
    
    func isFiltering() -> Bool {
        //searchField.reloadData();
        return !isSearchBarEmpty();
    }
}
extension EventListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isFiltering()) {
            print(filteredPlans[indexPath.row].title)
        }
        print(Plan.samplePlanList[indexPath.row].title)
    }
}

extension EventListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {return filteredPlans.count};
        return Plan.samplePlanList.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        let currentPlan: Plan;
        if isFiltering() {
            currentPlan = filteredPlans[indexPath.row];
        }
        else {
            currentPlan = Plan.samplePlanList[indexPath.row];
        }
        var cellConfig = cell.defaultContentConfiguration();
        cellConfig.text = currentPlan.title + " by " + currentPlan.owner.fullName;
        cellConfig.textProperties.color = .systemOrange;
        cellConfig.secondaryText = "Date: " + currentPlan.date + ", " + "Time: " + currentPlan.startTime1 + ", " + "Address: " + currentPlan.address;
        cellConfig.secondaryTextProperties.color = .systemOrange;
        cell.contentConfiguration = cellConfig;
        return cell;
        
    }
}

extension EventListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchText: searchBar.text!);
        
    }
}

extension EventListViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar;
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex];
        filterContentForSearchText(searchText: searchBar.text!);
        tableView.reloadData();
    }
}
