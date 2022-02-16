//
//  ShareViewController.swift
//  project1
//
//  Created by karmaln technology on 10/02/22.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet var shareTableView: UITableView!
    var titlecollection = ["Weather", "TV Shows", "Books", "Jokes", "Meme"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = shareTableView.dequeueReusableCell(withIdentifier: "shareWeatherCell", for: indexPath) as! ShareWeatherTableViewCell
            cell.weatherTitle.text = titlecollection[indexPath.row]
            return cell

        } else if indexPath.row == 1 {
            let cell = shareTableView.dequeueReusableCell(withIdentifier: "shareTvCell", for: indexPath) as! ShareTvTableViewCell
            cell.tvTitle.text = titlecollection[indexPath.row]
            return cell

        } else if indexPath.row == 2 {
            let cell = shareTableView.dequeueReusableCell(withIdentifier: "shareBooksCell", for: indexPath) as! ShareBookTableViewCell
            cell.bookTitle.text = titlecollection[indexPath.row]
            return cell
        } else if indexPath.row == 3 {
            let cell = shareTableView.dequeueReusableCell(withIdentifier: "shareJokesCell", for: indexPath) as! ShareJokesTableViewCell
            cell.jokesTitle.text = titlecollection[indexPath.row]
            return cell
        } else {
            let cell = shareTableView.dequeueReusableCell(withIdentifier: "shareMemeCell", for: indexPath) as! ShareMemeTableViewCell
            cell.titleofCollection.text = titlecollection[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 290
        } else if indexPath.row == 1 {
            return 291
        } else if indexPath.row == 2 {
            return 260
        } else if indexPath.row == 3 {
            return 237
        } else if indexPath.row == 4 {
            return 208
        } else {
            return 50
        }
    }
}
