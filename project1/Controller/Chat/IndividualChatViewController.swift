//
//  IndividualChatViewController.swift
//  project1
//
//  Created by karmaln technology on 07/02/22.
//

import UIKit

class IndividualChatViewController: UIViewController {
    @IBOutlet var userName: UILabel!
    @IBOutlet var dobLbl: UILabel!
    @IBOutlet var usernameIdLbl: UILabel!
    @IBOutlet var phoneLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet weak var fullUserName: UILabel!

    @IBOutlet weak var backgorundShadow: UIView!
    var userInfoIndividual: Result?

    func loadData() {

        userProfile.applyshadowWithCorner(containerView: backgorundShadow, cornerRadious: 100)

        let first:String = (userInfoIndividual?.name?.first)!
        let last:String = (userInfoIndividual?.name?.last)!
        let usertitle:String = (userInfoIndividual?.name?.title)!
        var dob:String = (userInfoIndividual?.dob?.date)!
        dob = dob.substring(to: 10)

        title = (userInfoIndividual?.name?.first)!
        userProfile.imageFromURL(urlString: (userInfoIndividual?.picture?.large)!)
        let raduis = userProfile.height / 2
        userProfile.raduis(reduisSize: raduis)
        userName.text = userInfoIndividual?.name?.first
        dobLbl.text = dob
        usernameIdLbl.text = userInfoIndividual?.login?.username
        phoneLbl.text = userInfoIndividual?.phone
        emailLbl.text = userInfoIndividual?.email
        addressLbl.text = userInfoIndividual?.location?.city
        fullUserName.text = "\(usertitle) \(first) \(last)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}



