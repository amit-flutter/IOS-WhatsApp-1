//
//  ShareWeatherTableViewCell.swift
//  project1
//
//  Created by karmaln technology on 14/02/22.
//

import Lottie
import UIKit

class ShareWeatherTableViewCell: UITableViewCell {
    @IBOutlet var weatherTitle: UILabel!
    @IBOutlet var shareWeatherCollectionView: UICollectionView!

    weak var activityIndicatorView: UIActivityIndicatorView!

    var shareWeatherInfo: ShareWeatherInfo?
    var shareManager = ShareInfoManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        shareWeatherCollectionView.delegate = self
        shareWeatherCollectionView.dataSource = self
        shareManager.delegateWeather = self
        shareManager.fetchShareInfo(withCode: 05)
        ActivityIndicator()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        shareWeatherCollectionView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

extension ShareWeatherTableViewCell: ShareInfoManagerDelegateWeather {
    func didUpdateShareWeather(share: ShareWeatherInfo) {
        print("Reload in ShareWeatherTableViewCell......!")
        DispatchQueue.main.async {
            self.shareWeatherInfo = share
            self.shareWeatherInfo?.nextDays?.append(NextDay(day: "Temp", comment: "Temp", maxTemp: Temp(c: 0, f: 0), minTemp: Temp(c: 0, f: 0), iconURL: "Temp"))
            self.activityIndicatorView.stopAnimating()
            self.shareWeatherCollectionView.reloadData()
            self.shareWeatherCollectionView.layoutIfNeeded()
        }
    }

    func didFailWithError(error: String) {
        print("Error In ShareWeatherTabelViewCell Delegate Load : \(error)")
    }
}

extension ShareWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareWeatherInfo?.nextDays?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shareWeatherCollectionView.dequeueReusableCell(withReuseIdentifier: "shareweathercollectioncell", for: indexPath) as! ShareWeatherCollectionViewCell
        cell.isClick = false

        if indexPath.row == 0 {
            cell.commentTitle.text = shareWeatherInfo?.currentConditions?.comment
            let day = shareWeatherInfo?.currentConditions?.dayhour?.dropsubstring(to: 8)
            cell.day.text = day
            cell.humidity.text = "Humidity: \(shareWeatherInfo?.currentConditions?.humidity ?? "")"
            cell.temp.text = "\(shareWeatherInfo?.currentConditions?.temp?.c ?? 0) °c"
            cell.wind.text = "Wind: \(shareWeatherInfo?.currentConditions?.wind?.km ?? 0) Km"
            cell.weatherImage.imageFromURL(urlString: (shareWeatherInfo?.currentConditions?.iconURL)!)
            cell.cellBackgroundView?.layer.cornerRadius = 15
            cell.cellBackgroundView?.backgroundColor = UIColor(named: "CGreen")
            cell.animationView.animation = Animation.named(setupWeatherAnimation(with: (shareWeatherInfo?.currentConditions?.comment)!))
        } else {
            cell.commentTitle.text = shareWeatherInfo?.nextDays?[indexPath.row - 1].comment
            let day = shareWeatherInfo?.nextDays?[indexPath.row - 1].day
            cell.day.text = day
            cell.humidity.text = "Min : \(shareWeatherInfo?.nextDays?[indexPath.row - 1].minTemp?.c ?? 0)"
            cell.temp.text = "\(shareWeatherInfo?.nextDays?[indexPath.row - 1].maxTemp?.c ?? 0) °c"
            cell.wind.text = "Max : \(shareWeatherInfo?.nextDays?[indexPath.row - 1].maxTemp?.c ?? 0)"
            cell.weatherImage.imageFromURL(urlString: (shareWeatherInfo?.nextDays?[indexPath.row - 1].iconURL)!)
            cell.animationView.animation = Animation.named(setupWeatherAnimation(with: (shareWeatherInfo?.nextDays?[indexPath.row - 1].comment)!))
            cell.cellBackgroundView?.backgroundColor = .clear
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 240)
    }

    func setupWeatherAnimation(with condition: String) -> String {
        var animationJson = "sun3"
        switch condition {
        case "Mostly sunny":
            animationJson = "suncloud1"
        case "Partly cloudy":
            animationJson = "rain2"
        case "Sunny":
            animationJson = "sun3"
        case "Smoke":
            animationJson = "smoke4"
        default:
            animationJson = "sun3"
        }
        return animationJson
    }
}
