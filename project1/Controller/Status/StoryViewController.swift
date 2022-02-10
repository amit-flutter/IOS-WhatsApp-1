//
//  ViewController.swift
//  PinterestUISwift
//
//  Created by farisalbalawi on 05/17/2019.
//  Copyright (c) 2019 farisalbalawi. All rights reserved.
//

import Hero
import PinterestUISwift
import UIKit

class StoryViewController: UIViewController {
    // MARK: - Variable

    var collectionView: UICollectionView!
    var textField: UITextField!
    var updateStoryInfo: StoryInfo?
    var storyManager = StoryManager()
    weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self

        textField.delegate = self

        storyManager.delegate = self
        storyManager.fatchData()
        ActivityIndicator()

        setupHideKeyboardOnTap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Loading Funcations

    func loadCollectionView() {
        let layout = collectionViewLayout(delegate: self)
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)

        view.addSubview(collectionView)

        collectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell2")
        collectionView.register(UINib(nibName: "Header", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white

        textField = UITextField(frame: CGRect(x: 0, y: 0, width: collectionView.width, height: 50))
//        textField.translatesAutoresizingMaskIntoConstraints = tr
        textField.placeholder = "Search New Story"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.go
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center

        collectionView.addSubview(textField)
    }

    func ActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        collectionView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
}

// MARK: - StoryManagerDelegate

extension StoryViewController: StoryManagerDelegate {
    func didUpdateStory(story: StoryInfo) {
        print("ReLoading....!")
        DispatchQueue.main.async {
            self.updateStoryInfo = story
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }

    func didFailWithError(error: String) {
        print(error)
    }
}

// MARK: - TextField Delegate

extension StoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let word = textField.text!
        if !word.isEmpty {
            textField.resignFirstResponder()
            return true
        } else {
            print("No Data")
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let word = textField.text {
            storyManager.fatchData(with: word)
            print("Word.....!")
        }
        textField.text = ""
    }
}

// MARK: - CollectionViewFlowDataSource

extension StoryViewController: collectionViewFlowDataSource {
    func sizeOfItemAtIndexPath(at indexPath: IndexPath) -> CGFloat {
        let height = (updateStoryInfo?.hits?[indexPath.row].imageHeight ?? 100) / 10
        return CGFloat(height)
    }

    func numberOfCols(at section: Int) -> Int {
        return UIDevice.current.userInterfaceIdiom == .phone ? 3 : 4
    }

    func spaceOfCells(at section: Int) -> CGFloat {
        return 12
    }

    func sectionInsets(at section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 10)
    }

    func sizeOfHeader(at section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 55)
    }

    func heightOfAdditionalContent(at indexPath: IndexPath) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension StoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return updateStoryInfo?.hits?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2

        cell.storyImage.imageFromURL(urlString: (updateStoryInfo?.hits?[indexPath.row].largeImageURL)!)
        cell.labelnew.text = updateStoryInfo?.hits?[indexPath.row].user?.uppercased()
        cell.storyUserProfile.imageFromURL(urlString: (updateStoryInfo?.hits?[indexPath.row].userImageURL)!)
        return cell
    }

    // MARK: header config

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! Header
//            return headerView
//        } else {
//            return UICollectionReusableView()
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Useing Segue
        performSegue(withIdentifier: "showfullstory", sender: indexPath.row)

        // Useing NavigationController
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "showfullstory") as! StoryDetailsViewController
        //        vc.storyInfo = updateStoryInfo?.hits?[indexPath.row]
        //        vc.hidesBottomBarWhenPushed = true
        //        navigationController?.pushViewController(vc, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            StoryDetailsViewController, let index =
            collectionView.indexPathsForSelectedItems?.first {
            destination.storyInfo = updateStoryInfo?.hits?[index.row]
        }
    }
}
