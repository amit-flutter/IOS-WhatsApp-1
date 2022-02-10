//
//  SideMenuTableViewController.swift
//  project1
//
//  Created by karmaln technology on 02/02/22.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    var settings: [String] = ["New Grouup", "Contacts", "Calls", "People Nearby", "Saved Messages", "Settings", "Invite Friends", "Telegram Features"]
    var icon: [String] = ["person.3", "person.crop.square", "phone", "figure.walk.circle", "paperplane", "gear", "person.badge.plus", "wand.and.stars"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.text = settings[indexPath.row]
        cell.imageView?.image = UIImage(systemName: icon[indexPath.row])
        cell.name?.text = "aa"
        return cell
    }
}
