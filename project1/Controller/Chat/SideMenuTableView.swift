//
//  SideMenuTableViewController.swift
//  project1
//
//  Created by karmaln technology on 02/02/22.
//

import UIKit

protocol SidemenuTableViewDelegate {
    func didselectMenuItem(named: String)
}

class SidemenuTableView: UITableViewController {
    var settings: [String] = ["New Grouup", "Contacts", "Calls", "People Nearby", "Saved Messages", "Settings", "Invite Friends", "Telegram Features"]
    var icon: [String] = ["person.3", "person.crop.square", "phone", "figure.walk.circle", "paperplane", "gear", "person.badge.plus", "wand.and.stars"]

    @IBOutlet weak var sideMenuItemIcon: UIImageView!
    public var delegate: SidemenuTableViewDelegate?
    private let color = UIColor(named: "CGreen")
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menucell1")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = color
        view.backgroundColor = color
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    override func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menucell1", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        cell.backgroundColor = color
        cell.textLabel?.textColor = .systemBackground
        cell.contentView.backgroundColor = color
        cell.imageView?.image = UIImage(named: icon[indexPath.row])
        return cell
    }

    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let selectedItem = settings[indexPath.row]
        delegate?.didselectMenuItem(named: selectedItem)
    }
}
