//
//  FriendListViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 4/11/22.
//

import UIKit

class FriendListViewController: UIViewController {

    @IBOutlet weak var friendTable: UITableView!
    
    var friends = User.sampleFriendList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendTable.delegate = self;
        friendTable.dataSource = self;
        // Do any additional setup after loading the view.
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
extension FriendListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension FriendListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        var cellConfig = cell.defaultContentConfiguration();
        cellConfig.text = friends[indexPath.row].fullName;
        cellConfig.secondaryText = friends[indexPath.row].userName;
        cellConfig.textProperties.color = .systemOrange;
        cellConfig.secondaryTextProperties.color = .systemOrange;
        cell.contentConfiguration = cellConfig;
        return cell;
    }
}
