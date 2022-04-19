import UIKit

class EventListViewController: UIViewController {
    
    let activeUser : User = User.sampleUser
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func unwindToList(_ sender: UIStoryboardSegue) {}
    
    static let detailSegueID = "PlanDetailSegue"
    
    var filteredPlans = [Plan]();
    
    var searchBarIsFull = false;
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.detailSegueID,
            let dest = segue.destination as? PlanDetailViewController,
            let cell = sender as? UITableViewCell,
           let indexPath = self.tableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            guard let plan : Plan = getPlan(at: rowIndex) else {
                fatalError("couldn't get plan")
            }
            dest.configure(with: plan, editAction: { plan in
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        searchBar.delegate = self;
        searchBar.searchTextField.textColor = .orange
    }
    
    
    
    func filterContentForSearchText(searchText: String) {
        filteredPlans = activeUser.plans.filter({(plan: Plan) -> Bool in
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
    
    func getPlan(at rowIndex: Int) -> Plan? {
        return filteredPlans[rowIndex]
    }
}
extension EventListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isFiltering()) {
            print(filteredPlans[indexPath.row].title)
        }
        print(activeUser.plans[indexPath.row].title)
    }
}

extension EventListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {return filteredPlans.count};
        return activeUser.plans.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        let currentPlan: Plan;
        if isFiltering() {
            currentPlan = filteredPlans[indexPath.row];
        }
        else {
            currentPlan = activeUser.plans[indexPath.row];
        }
        var cellConfig = cell.defaultContentConfiguration();
        cellConfig.text = currentPlan.title + " by " + currentPlan.owner.fullName;
        cellConfig.textProperties.color = .systemOrange;
        cellConfig.secondaryText = "Date: " + Plan.dayText(currentPlan.day) + ", " + "Time: " + Plan.timeText(currentPlan.startTime) + ", " + "Address: " + currentPlan.address;
        cellConfig.secondaryTextProperties.color = .systemOrange;
        cell.contentConfiguration = cellConfig;
        return cell;
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let share = UITableViewRowAction(style: .normal, title: "Mark as Done") { action, index in
                if self.isFiltering() == true {
                    print("Is Filtering");
                }
                else {
                    User.sampleUser.plans.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            }
            share.backgroundColor = UIColor.red
            return [share]
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
