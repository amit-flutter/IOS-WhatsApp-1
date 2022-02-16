//
//  Header.swift
//  PinterestUISwift_Example
//
//  Created by Faris Albalawi on 5/17/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class Header: UICollectionReusableView, UITextFieldDelegate {
    @IBOutlet var searchStories: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        searchStories.delegate = self
    }

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
        if let word = searchStories.text {
            StoryManager().fatchData(with: word)
            print("Calling Api By Word.....!")
        }
        searchStories.text = ""
    }
}
