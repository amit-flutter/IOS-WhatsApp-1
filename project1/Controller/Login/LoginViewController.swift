//
//  LoginViewController.swift
//  project1
//
//  Created by karmaln technology on 03/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var loginBtn: LoadingButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var contryCode: UITextField!
    var isLoginSuccessfully: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.raduis(reduisSize: 20)
        textField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        textField.delegate = self
    }

    private func checkAuthentication(with phoneNumber: String) {
        print("--------------------")
        print(phoneNumber)
        print("This is Login Number")
    }

    // navigate to home-screen after successfull login
    @IBAction func loginBtnAction(_ sender: UIButton) {
//        guard let phoneNumber = textField.text, !textField.text!.isEmpty else {
//            let alert = UIAlertController(title: "Enter Phone Number First", message: nil, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
//        checkAuthentication(with: phoneNumber)

        if isLoginSuccessfully {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } else {
            loginBtn.loadIndicator(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.loginBtn.loadIndicator(false)
                let alert = UIAlertController(title: "Login Faild", message: "\nPlease Enter Vaild Mobile Number\n\nEdit Phone Number and Try Again.\n", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                alert.view.tintColor = .red
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 10
    }
}

class LoadingButton: UIButton {
    var activityIndicator: UIActivityIndicatorView!

    let activityIndicatorColor: UIColor = .label

    func loadIndicator(_ shouldShow: Bool) {
        if shouldShow {
            if activityIndicator == nil {
                activityIndicator = createActivityIndicator()
            }
            isEnabled = false
            alpha = 0.5
            showSpinning()
        } else {
            activityIndicator.stopAnimating()
            isEnabled = true
            alpha = 1.0
        }
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        positionActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func positionActivityIndicatorInButton() {
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: activityIndicator,
                                                    attribute: .trailing,
                                                    multiplier: 1, constant: 16)
        addConstraint(trailingConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }
}
