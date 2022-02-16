//
//  ShareBookCollectionViewCell.swift
//  project1
//
//  Created by karmaln technology on 14/02/22.
//

import UIKit

class ShareBookCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitle: UILabel!
    @IBOutlet weak var imageBackView: UIView!

    @IBOutlet var labelTopMargin: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.raduis(reduisSize: 10)
    }

    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.bookImage.transform = self.isSelected ? CGAffineTransform(scaleX: 1.3, y: 1.3) : CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
