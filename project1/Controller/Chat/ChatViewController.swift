//
//  ChatViewController.swift
//  project1
//
//  Created by karmaln technology on 02/02/22.
//

import SideMenu
import UIKit

class ChatViewController: UIViewController {
    private var sidemenu: SideMenuNavigationController?
    private var updatedUserserInfo: UserInfo?
    private var userInfoManager = UserInfoManager()
    private var isFatching: Bool = false
    private var btn = UIButton(type: .custom)

    @IBOutlet var chatTableview: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WhatsApp"

        // Configur Sidemenu
        SidemenuConfig()

        // Configur TableView ( Custome Cell With Xib File )
        chatTableview.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "chatcell")
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
        let menu = SidemenuTableView()
        menu.delegate = self
        sidemenu = SideMenuNavigationController(rootViewController: menu)
        sidemenu!.leftSide = true
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = sidemenu
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        chatTableview.backgroundView = activityIndicatorView
        chatTableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }

    func floatingButton() {
        btn.frame = CGRect(x: view.width - 90, y: view.height - 160, width: 60, height: 60)
        btn.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        btn.tintColor = .systemBackground
        btn.backgroundColor = UIColor(named: "CGreen")
        btn.raduis(reduisSize: 30)
        btn.addTarget(self, action: #selector(didTapfloatButton), for: .touchUpInside)
        view.addSubview(btn)
    }

    @objc private func didTapfloatButton() {
        print("pressed")
        guard let image = UIImage(named: "Image1"), let url = URL(string: "http://google.com") else { return }
        let data = ["Text, Image and url", image, url] as [Any]
        UIApplication.share(data)
    }

    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
        present(sidemenu!, animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        updatedUserserInfo?.results!.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
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

        // fatching new data from server by making api call
        // calling function when user reach to the end of the cell
        if indexPath.section == (updatedUserserInfo?.results!.count)! - 1 { // last cell
            if updatedUserserInfo?.results!.count ?? 0 > 0 {
                // fetch more data
                print("Flag : \(isFatching)")
                if !isFatching {
                    print("---------------- fetch more")
                    isFatching = true
                    chatTableview.tableFooterView = createSpinenrFooter()
                    userInfoManager.fetchUserInfo(pagination: true)
                }
            }
        }
        return cell
    }

    private func createSpinenrFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size
                .width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
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
        DispatchQueue.main.async { [self] in
            print("Updating.....!")
            if isFatching {
                self.updatedUserserInfo?.results?.append(contentsOf: user.results!)
                isFatching = false
            } else {
                self.updatedUserserInfo = user
            }
            self.activityIndicatorView.stopAnimating()
            self.chatTableview.reloadData()
            self.chatTableview.tableFooterView = nil
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

extension ChatViewController: SidemenuTableViewDelegate {
    func didselectMenuItem(named: String) {
        print(named)
        sidemenu?.dismiss(animated: true, completion: {
            if named == "Home" {
            } else if named == "Info" {
            } else if named == "Settings" {
            }
        })
    }
}
