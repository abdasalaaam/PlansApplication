//
//  SearchViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 4/11/22.

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchField: UITableView!
    
    var invitations = ["John Smith, click to accept", "Demarcus Cousins, click to accept"];
    var filteredUsers = [User]();
    var usersInvited = User.sampleFriendList
    var searchBarIsFull = false; 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self;
        searchField.dataSource = self;
        searchBar.delegate = self;
        searchBar.searchTextField.textColor = .orange

    }
    
    func filterContentForSearchText(searchText: String) {
        filteredUsers = usersInvited.filter({(user: User) -> Bool in
            return user.fullName.lowercased().contains(searchText.lowercased()) || user.userName.lowercased().contains(searchText.lowercased());
        });
        searchField.reloadData();
    }
    
    func isSearchBarEmpty() -> Bool {
        if(searchBar.text! != "") {
           // print("search bar full");
            return false;
        }
       // print("search bar empty");
        return true;
        //return searchBar.text?.isEmpty ?? true;
    }
    
    func isFiltering() -> Bool {
        //searchField.reloadData();
        return !isSearchBarEmpty();
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
extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filteredUsers[indexPath.row].fullName);
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {return filteredUsers.count};
        return 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        let currentUser :User;
        if isFiltering() {
            currentUser = filteredUsers[indexPath.row];
            print("hi)");
        }
        else {
            currentUser = usersInvited[indexPath.row];
            //print("hi)");
        }
        var cellConfig = cell.defaultContentConfiguration();
        cellConfig.text = currentUser.fullName + ", " + currentUser.userName;
        cellConfig.textProperties.color = .systemOrange;
        cellConfig.secondaryText = "Click to add";
        cellConfig.secondaryTextProperties.color = .systemOrange;
        cell.contentConfiguration = cellConfig;
        return cell;
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchText: searchBar.text!);
        
    }
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar;
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex];
        filterContentForSearchText(searchText: searchBar.text!);
        searchField.reloadData();
    }
}
