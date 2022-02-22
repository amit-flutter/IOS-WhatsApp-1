//
//  ChatTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 03/02/22.
//

import UIKit
protocol ChatTableViewCellDelegate {
    func didTapImage()
    func didTapChat()
}

class ChatTableViewCell: UITableViewCell {
    @IBOutlet var chatView: UIView!
    var menu: SidemenuTableView?
    var delegate: ChatTableViewCellDelegate?

    @IBOutlet var userProfileImage: UIImageView?
    @IBOutlet var userName: UILabel?
    @IBOutlet var userStatus: UILabel?
    @IBOutlet var userActiveTime: UILabel?
    @IBOutlet var downArrow: UIButton?

    var isOpen: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userProfileImage?.raduis(reduisSize: 20)

//        let viewTap = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
//        chatView.addGestureRecognizer(viewTap)
//        chatView.isUserInteractionEnabled = true
//
//        let imageTap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
//        userProfileImage?.addGestureRecognizer(imageTap)
//        userProfileImage?.isUserInteractionEnabled = true
    }

    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        print("Tap View")
        delegate?.didTapChat()
    }

    @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
        print("Tap Image")
        delegate?.didTapImage()
    }

    weak var myVC: UIViewController?
    @IBAction func downArrorPressed(_ sender: UIButton) {
        if isOpen {
            print("1")
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            print("Changed2....")
        }
        isOpen = !isOpen
        // here I want to execute the UIActionSheet
        let actionsheet = UIAlertController(title: "Options", message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        actionsheet.addAction(UIAlertAction(title: "New group", style: UIAlertAction.Style.default))
        actionsheet.addAction(UIAlertAction(title: "New broadcast", style: UIAlertAction.Style.default))
        actionsheet.addAction(UIAlertAction(title: "Linked device", style: UIAlertAction.Style.default))
        actionsheet.addAction(UIAlertAction(title: "Starred messages", style: UIAlertAction.Style.default))
        actionsheet.addAction(UIAlertAction(title: "Setting", style: UIAlertAction.Style.default) { _ in
            print("enter")
            self.myVC?.present(self.menu!, animated: true, completion: nil)
        })

        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (_) -> Void in
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            print("return....")
        }))

        myVC?.present(actionsheet, animated: true) {
            if let mainView = actionsheet.view.superview?.subviews[0] {
                mainView.isUserInteractionEnabled = false
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
