//
//  StoryDetailsViewController.swift
//  project1
//
//  Created by karmaln technology on 09/02/22.
//

import Hero
import UIKit

class StoryDetailsViewController: UIViewController {
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var viewsCount: UILabel!
    @IBOutlet var commentsCount: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var storyImage: UIImageView!
    
    var storyInfo: Hit?
    override func viewDidLoad() {
        super.viewDidLoad()
        likeCount.text = storyInfo!.likes!.description
        userImage.imageFromURL(urlString: storyInfo!.userImageURL!)
        viewsCount.text = storyInfo!.views!.description
        commentsCount.text = storyInfo!.comments!.description
        userName.text = storyInfo!.user!
        storyImage.imageFromURL(urlString: storyInfo!.largeImageURL!)

        userImage.raduis(reduisSize: userImage.height / 2)
        storyImage.raduis(reduisSize: 10)
    }

    @IBAction func swipDownAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        switch sender.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
            let currentPosition = CGPoint(x: translation.x + storyImage.center.x, y: translation.y + storyImage.center.y)
            Hero.shared.apply(modifiers: [.position(currentPosition)], to: storyImage)
        default:
            if progress > 0.1 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}
