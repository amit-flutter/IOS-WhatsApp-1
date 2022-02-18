//
//  IndividualChatViewController.swift
//  project1
//
//  Created by karmaln technology on 07/02/22.
//

import Hero
import UIKit

class IndividualChatViewController: UIViewController {
    @IBOutlet var userName: UILabel!
    @IBOutlet var dobLbl: UILabel!
    @IBOutlet var usernameIdLbl: UILabel!
    @IBOutlet var phoneLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var fullUserName: UILabel!

    @IBOutlet var changeUserProfile: UIButton!
    @IBOutlet var backgorundShadow: UIView!
    var userInfoIndividual: Result?
    var isZoom: Bool = false

    func loadData() {
        let first: String = (userInfoIndividual?.name?.first)!
        let last: String = (userInfoIndividual?.name?.last)!
        let usertitle: String = (userInfoIndividual?.name?.title)!
        var dob: String = (userInfoIndividual?.dob?.date)!
        dob = dob.substring(to: 10)

        dobLbl.text = dob
        title = (userInfoIndividual?.name?.first)!
        userProfile.imageFromURL(urlString: (userInfoIndividual?.picture?.large)!)
        userName.text = userInfoIndividual?.name?.first
        usernameIdLbl.text = userInfoIndividual?.login?.username
        phoneLbl.text = userInfoIndividual?.phone
        emailLbl.text = userInfoIndividual?.email
        addressLbl.text = userInfoIndividual?.location?.city
        fullUserName.text = "\(usertitle) \(first) \(last)"
    }

    func loadUi() {
        userProfile.hero.id = "ironMan"
        userProfile.applyshadowWithCorner(containerView: backgorundShadow, cornerRadious: 100)
        userProfile.raduis(reduisSize: userProfile.height / 2)
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
//        userProfile.isUserInteractionEnabled = true
//        userProfile.addGestureRecognizer(tapGestureRecognizer)
        changeUserProfile.raduis(reduisSize: changeUserProfile.width / 2)
        changeUserProfile.border(borderSize: 2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUi()
        loadData()
    }

    @IBAction func changeUserProfileAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "gotoChangeProfile") as! ChangeProfileViewController
        vc.profileImageLink = userInfoIndividual?.picture?.large
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func tapImage() {
        isZoom = !isZoom
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.userProfile.transform = self.isZoom ? CGAffineTransform(translationX: 1.3, y: 1.3) : CGAffineTransform.identity
            self.userProfile.enableZoom()
        }, completion: nil)
    }
}
