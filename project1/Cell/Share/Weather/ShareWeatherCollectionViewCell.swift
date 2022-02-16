//
//  ShareWeatherCollectionViewCell.swift
//  project1
//
//  Created by karmaln technology on 15/02/22.
//

import Lottie
import UIKit

class ShareWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var backImageView: UIView!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var commentTitle: UILabel!
    @IBOutlet var day: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var temp: UILabel!

    let animationView = AnimationView()
    var isClick:Bool?

    override func awakeFromNib() {
        super.awakeFromNib()
        weatherImage.raduis(reduisSize: 25)
        weatherImage.applyshadowWithCorner(containerView: backImageView, cornerRadious: 25)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkAction))
        backImageView.addGestureRecognizer(gesture)
    }

    @objc func checkAction(sender: UITapGestureRecognizer) {
        isClick = !isClick!
        if isClick! {
            UIView.transition(with: backImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.weatherImage.isHidden = true
                self.animationView.isHidden = false
                self.animationView.frame = self.backImageView.bounds
                self.animationView.contentMode = .scaleAspectFill
                self.animationView.loopMode = .loop
                self.animationView.play()
                self.backImageView.addSubview(self.animationView)
            }, completion: nil)
        } else {
            UIView.transition(with: backImageView, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.weatherImage.isHidden = false
                self.animationView.stop()
                self.animationView.isHidden = true
            }, completion: nil)
        }
    }
}
