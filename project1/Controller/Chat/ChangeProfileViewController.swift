//
//  ChangeProfileViewController.swift
//  project1
//
//  Created by karmaln technology on 17/02/22.
//

import Photos
import PhotosUI
import RealmSwift
import UIKit

class ChangeProfileViewController: UIViewController {
    let realm = try! Realm()

    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var nikeNameTF: UITextField!
    @IBOutlet var hobbiesTF: UITextField!
    @IBOutlet var skillsTF: UITextField!
    @IBOutlet var bestFriendTF: UITextField!
    @IBOutlet var submitBtn: UIButton!

    var profileImageLink: String?
    private var itemProviders = [NSItemProvider]()

    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        userProfile.hero.id = "ironMan"
        userProfile.hero.id = "ironMan"
        userProfile.heroID = "ironMan"
        submitBtn.raduis(reduisSize: submitBtn.height / 2)
        userProfile.imageFromURL(urlString: profileImageLink!)
        userProfile.raduis(reduisSize: 10)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserImage))
        userProfile.isUserInteractionEnabled = true
        userProfile.addGestureRecognizer(tapGesture)
        loadData()
    }

    @objc func tapUserImage() {
        print("Getting Image")
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 3
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    func loadData(flag: Bool = false) {
        let userDataFromRealm = realm.objects(userData.self)
        nikeNameTF.text = flag ? "Reloaded Data :\(userDataFromRealm.last?.nikeName ?? "Null    ")" : userDataFromRealm.last?.nikeName
        hobbiesTF.text = userDataFromRealm.last?.hobbies
        skillsTF.text = userDataFromRealm.last?.skills
        bestFriendTF.text = userDataFromRealm.last?.friends
    }

    @IBAction func submitBtnAction(_ sender: UIButton) {
        saveData()
    }

    func saveData() {
        print("Start Saving...")
        let userdata = userData()
        userdata.nikeName = nikeNameTF.text ?? "No Name"
        userdata.hobbies = hobbiesTF.text ?? "No Hobbies"
        userdata.skills = skillsTF.text ?? "No Skills"
        userdata.friends = bestFriendTF.text ?? "No Frineds"

        do {
            try realm.write {
                realm.add(userdata)
                print("Data Saved...")
                loadData(flag: true)
                print("Realoded SucessFully")
            }
        } catch {
            print("Error while saving userData in Realm Data base : \(error)")
        }
    }
}

extension ChangeProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

//        for item in results {
//            item.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
//                if let image = image as? UIImage {
//                    print(image)
//                }}}

        itemProviders = results.map(\.itemProvider)
        let item = itemProviders.first
        print("*******")
        print(item)
        if (item?.canLoadObject(ofClass: UIImage.self)) != nil {
            item?.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
                DispatchQueue.main.async {
                    print("image: \(image)")
                    if let image = image as? UIImage {
                        self.userProfile.image = image
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            })
        } else {
            print("can't load")
        }
    }
}
