//
//  ShareCollectionViewCell.swift
//  project1
//
//  Created by karmaln technology on 11/02/22.
//

import UIKit

class ShareMemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var shareImage: UIImageView!
    @IBOutlet var shareLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        shareImage.raduis(reduisSize: 10)
    }
    
}
