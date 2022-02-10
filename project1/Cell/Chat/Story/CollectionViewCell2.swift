//
//  CollectionViewCell.swift
//  PinterestUISwift_Example
//
//  Created by Faris Albalawi on 5/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Hero

class CollectionViewCell2: UICollectionViewCell {
    @IBOutlet weak var labelnew: UILabel!
    @IBOutlet weak var storyUserProfile: UIImageView!
    @IBOutlet weak var storyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        storyImage.raduis(reduisSize: 10)
        storyUserProfile.raduis(reduisSize: 17.5)
        storyImage.heroID = "StoryImage"
        storyUserProfile.heroID = "StoryUserProfile"
    }
}
