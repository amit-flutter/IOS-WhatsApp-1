//
//  ViewController.swift
//  project1
//
//  Created by karmaln technology on 02/02/22.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

class WelcomeViewController: UIViewController {
    @IBOutlet var agree_continueBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        agree_continueBtn.raduis(reduisSize: 30)
        
    }

    @IBAction func agreecontinueAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        present(vc, animated: true, completion: nil)
    }
}
