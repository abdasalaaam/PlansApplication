//
//  InviteViewController.swift
//  Plans2.0
//
//  Created by Alex Pallozzi on 4/10/22.
//

import UIKit

class InviteViewController: UIViewController{
    
    /*private let table: UITableView = {
        let table = UITableView();
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        return table;
    }()*/
    
    @IBOutlet var tableView: UITableView!;
    
    var invitations = ["John Smith" , "Demarcus Cousins"];
    var usersInv = User.sampleFriendList
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.delegate = self;
        tableView.dataSource = self;
        //tableView.backgroundColor = .systemGray2
        //title = "Invite List";
        //view.addSubview(table);
       // table.dataSource = self;
    }
}
extension InviteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(invitations[indexPath.row]);
        //
    }
}

extension InviteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersInv.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        var cellConfig = cell.defaultContentConfiguration();
        cellConfig.text = usersInv[indexPath.row].fullName + ", " + usersInv[indexPath.row].userName;
        cellConfig.secondaryText = "Click to Add!";
        cellConfig.secondaryTextProperties.color = .systemOrange;
        cellConfig.textProperties.color = .systemOrange;
        cell.contentConfiguration = cellConfig;
        return cell;
    }
}
