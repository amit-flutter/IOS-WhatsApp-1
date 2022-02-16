//
//  ShareTvTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 14/02/22.
//

import UIKit

class ShareTvTableViewCell: UITableViewCell {
    @IBOutlet var shareTvCollectionView: UICollectionView!
    @IBOutlet var tvTitle: UILabel!

    weak var activityIndicatorView: UIActivityIndicatorView!

    var shareTvInfo: ShareTvInfo?
    var shareManager = ShareInfoManager()

    var timer = Timer()
    var count = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        shareTvCollectionView.delegate = self
        shareTvCollectionView.dataSource = self
        shareManager.delegateTv = self
        shareManager.fetchShareInfo(withCode: 04)
        ActivityIndicator()
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeIamge), userInfo: nil, repeats: true)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        shareTvCollectionView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }

    @objc func changeIamge() {
        if count < (shareTvInfo?.count)! {
            let rect = shareTvCollectionView.layoutAttributesForItem(at: IndexPath(row: count, section: 0))?.frame
            shareTvCollectionView.scrollRectToVisible(rect!, animated: true)
            count += 1
        } else {
            count = 0
            let rect = shareTvCollectionView.layoutAttributesForItem(at: IndexPath(row: count, section: 0))?.frame
            shareTvCollectionView.scrollRectToVisible(rect!, animated: true)
            count = 1
        }
    }
}

extension ShareTvTableViewCell: ShareInfoManagerDelegateTv {
    func didUpdateShareTv(share: ShareTvInfo) {
        print("Reload in ShareTvTableViewCell......!")
        DispatchQueue.main.async {
            self.shareTvInfo = share
            self.activityIndicatorView.stopAnimating()
            self.shareTvCollectionView.reloadData()
            self.shareTvCollectionView.layoutIfNeeded()
        }
    }

    func didFailWithError(error: String) {
        print("Error In ShareTvTabelViewCell Delegate Load : \(error)")
    }
}

extension ShareTvTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareTvInfo?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shareTvCollectionView.dequeueReusableCell(withReuseIdentifier: "sharetvcollectioncell", for: indexPath) as! ShareTvCollectionViewCell
        cell.tvImage.imageFromURL(urlString: (shareTvInfo?[indexPath.row].image?.medium!)!)
        cell.tvTitle.text = "Title: \(shareTvInfo?[indexPath.row].name ?? "0")"
        cell.tvCountry.text = "Country: \(shareTvInfo?[indexPath.row].network?.country?.name ?? "0")"
        cell.tvTime.text = "Time : \(shareTvInfo?[indexPath.row].weight ?? 0)"
        cell.tvRating.text = "Rating :\(shareTvInfo?[indexPath.row].rating?.average ?? 0)"
        cell.tvGenres.text = "Tag :\(shareTvInfo?[indexPath.row].genres!.getElement(at: 0) ?? ""),\(shareTvInfo?[indexPath.row].genres!.getElement(at: 1) ?? ""),\(shareTvInfo?[indexPath.row].genres!.getElement(at: 2) ?? "")"
        cell.tvSummery.text = "Language: \(shareTvInfo?[indexPath.row].language ?? "0")"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
}
