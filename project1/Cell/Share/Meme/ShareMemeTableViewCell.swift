//
//  ShareTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 10/02/22.
//

import UIKit

class ShareMemeTableViewCell: UITableViewCell {
    @IBOutlet var titleofCollection: UILabel!
    @IBOutlet var shareCollectionView: UICollectionView!

    weak var activityIndicatorView: UIActivityIndicatorView!

    var shareMemeInfo: ShareMemeInfo?
    var shareManager = ShareInfoManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        shareCollectionView.delegate = self
        shareCollectionView.dataSource = self
        shareManager.delegateMemo = self
        shareManager.fetchShareInfo(withCode: 01)
        ActivityIndicator()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        shareCollectionView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

extension ShareMemeTableViewCell: ShareInfoManagerDelegateMemo {
    func didUpdateShareMeme(share: ShareMemeInfo) {
        print("Reload in ShareTableViewCell......!")
        DispatchQueue.main.async {
            self.shareMemeInfo = share
            self.shareMemeInfo?.data?.memes = Array((share.data?.memes?.reversed())!)
            self.activityIndicatorView.stopAnimating()
            self.shareCollectionView.reloadData()
        }
    }

    func didFailWithError(error: String) {
        print("Error In ShareTabelViewCell Delegate Load : \(error)")
    }
}

extension ShareMemeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareMemeInfo?.data?.memes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shareCollectionView.dequeueReusableCell(withReuseIdentifier: "sharecollectioncell", for: indexPath) as! ShareMemeCollectionViewCell
        cell.shareImage.imageFromURL(urlString: (shareMemeInfo?.data?.memes?[indexPath.row].url!)!)
        cell.shareLabel.text = shareMemeInfo?.data?.memes?[indexPath.row].name!

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 167, height: 156)
    }
}
