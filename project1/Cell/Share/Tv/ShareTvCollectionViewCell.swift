//
//  ShareTvCollectionViewCell.swift
//  project1
//
//  Created by karmaln technology on 15/02/22.
//

import UIKit

class ShareTvCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tvImage: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvRating: UILabel!
    @IBOutlet weak var tvGenres: UILabel!
    @IBOutlet weak var tvTime: UILabel!
    @IBOutlet weak var tvCountry: UILabel!
    @IBOutlet weak var tvSummery: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        tvImage.raduis(reduisSize: 20)
    }
}
