//
//  ChatViewController.swift
//  project1
//
//  Created by karmaln technology on 02/02/22.
//

import SideMenu
import UIKit

class ChatViewController: UIViewController {
    var menu: SideMenuNavigationController?
    var updatedUserserInfo: UserInfo?
    var userInfoManager = UserInfoManager()

    @IBOutlet var chatTableview: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!

    var btn = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WhatsApp"

        // Configur Sidemenu
        SidemenuConfig()

        // Configur TableView
        chatTableview.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "chatcell") // Custome Cell With Xib File
        chatTableview.delegate = self
        chatTableview.dataSource = self

        // UserInfo Managager Delegate
        userInfoManager.delegate = self
        userInfoManager.fetchUserInfo()

        // Loading Indicator
        ActivityIndicator()

        // Floating Button
        floatingButton()
    }

    func SidemenuConfig() {
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = menu
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        chatTableview.backgroundView = activityIndicatorView
        chatTableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }

    func floatingButton() {
        btn.frame = CGRect(x: view.width - 90, y: view.height - 190, width: 60, height: 60)
        btn.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        btn.tintColor = .systemBackground
        btn.backgroundColor = UIColor(named: "CGreen")
        btn.raduis(reduisSize: 30)
        addButtonAction()
        view.addSubview(btn)
    }

    private func addButtonAction() {
        btn.addTarget(self, action: #selector(didTapfloatButton), for: .touchUpInside)
    }

    @objc private func didTapfloatButton() {
        print("pressed")

        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)

        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            (_: UIAlertAction!) -> Void in
            print("Saved")
        })

        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
            (_: UIAlertAction!) -> Void in
            print("Deleted")
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (_: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
    }

    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        present(menu!, animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        updatedUserserInfo?.results!.count ?? 0
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath) as! ChatTableViewCell
        cell.userName?.text = updatedUserserInfo?.results?[indexPath.section].name?.first
        cell.userStatus?.text = updatedUserserInfo?.results?[indexPath.section].email
        cell.userActiveTime?.text = String((updatedUserserInfo?.results?[indexPath.section].dob?.age)!)
        cell.userProfileImage?.imageFromURL(urlString: (updatedUserserInfo?.results?[indexPath.section].picture?.large!)!)
        cell.delegate = self
        cell.myVC = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "individualchat") as! IndividualChatViewController
        newViewController.userInfoIndividual = updatedUserserInfo?.results?[indexPath.section]
        newViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension ChatViewController: UserInfoManagerDelegate {
    func didUpdateUser(user: UserInfo) {
        DispatchQueue.main.async {
            print("Updating.....!")
            self.updatedUserserInfo = user
            self.activityIndicatorView.stopAnimating()
            self.chatTableview.reloadData()
        }
    }

    func didFailWithError(error: String) {
        print(error)
    }
}

extension ChatViewController: ChatTableViewCellDelegate {
    func didTapImage() {
        print("didTapImage")
    }

    func didTapChat() {
        print("didTapChat")
    }
}
