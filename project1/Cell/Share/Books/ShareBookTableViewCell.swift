//
//  ShareBookTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 14/02/22.
//

import UIKit

class ShareBookTableViewCell: UITableViewCell {
    @IBOutlet var shareBookCollectionView: UICollectionView!
    @IBOutlet var bookTitle: UILabel!

    weak var activityIndicatorView: UIActivityIndicatorView!

    var shareBookInfo: ShareBookInfo?
    var shareManager = ShareInfoManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        shareBookCollectionView.delegate = self
        shareBookCollectionView.dataSource = self
        shareManager.delegateBooks = self
        shareManager.fetchShareInfo(withCode: 03)
        ActivityIndicator()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        shareBookCollectionView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

extension ShareBookTableViewCell: ShareInfoManagerDelegateBooks {
    func didUpdateShareBooks(share: ShareBookInfo) {
        print("Reload in ShareBookTableViewCell......!")
        DispatchQueue.main.async {
            self.shareBookInfo = share
            self.activityIndicatorView.stopAnimating()
            self.shareBookCollectionView.reloadData()
        }
    }

    func didFailWithError(error: String) {
        print("Error In ShareBookTabelViewCell Delegate Load : \(error)")
    }
}

extension ShareBookTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareBookInfo?.books?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shareBookCollectionView.dequeueReusableCell(withReuseIdentifier: "sharebookcollectioncell", for: indexPath) as! ShareBookCollectionViewCell
        cell.bookImage.imageFromURL(urlString: (shareBookInfo?.books?[indexPath.row].image)!)
        cell.bookTitle.text = shareBookInfo?.books?[indexPath.row].price!

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 204)
    }
}
