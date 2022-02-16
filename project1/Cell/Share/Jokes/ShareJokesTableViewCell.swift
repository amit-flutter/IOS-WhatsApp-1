//
//  ShareJokesTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 14/02/22.
//

import UIKit

class ShareJokesTableViewCell: UITableViewCell {
    @IBOutlet var jokesTitle: UILabel!
    @IBOutlet weak var fullJokes: UILabel!
    @IBOutlet weak var newJokes: UIButton!
    var shareManager = ShareInfoManager()

    weak var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        shareManager.delegateJokes = self
        shareManager.fetchShareInfo(withCode: 02)
        newJokes.raduis(reduisSize: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func newJokesBtn(_ sender: UIButton) {
        print("-----[Request for new Jokes]-----")
        shareManager.fetchShareInfo(withCode: 02)
    }
}

extension ShareJokesTableViewCell: ShareInfoManagerDelegateJokes{
    func didUpdateShareJokes(share: ShareJokesInfo) {
        DispatchQueue.main.async {
            self.fullJokes.text = share.joke!
            self.fullJokes.reloadInputViews()
        }
    }

    func didFailWithError(error: String) {
        print("Error while updating new jokes in Share jokes Table View")
    }
}
