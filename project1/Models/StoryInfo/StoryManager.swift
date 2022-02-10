//
//  StoryManager.swift
//  project1
//
//  Created by karmaln technology on 09/02/22.
//

import Foundation

protocol StoryManagerDelegate {
    func didUpdateStory(story: StoryInfo)
    func didFailWithError(error: String)
}

struct StoryManager {
    var delegate: StoryManagerDelegate?

    func fatchData(with word: String? = nil) {
        _ = "16006973-f218fb6f3efe3f0f8b1c17674"
        let searchWord = word ?? "nature+rain"
        let url = "https://pixabay.com/api/?key=16006973-f218fb6f3efe3f0f8b1c17674&q=\(searchWord)&image_type=photo&pretty=true"
        performStory(with: url)
    }

    func performStory(with url: String) {
        print("PerformStory Start....")
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                data, _, error in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: "error")
                    return
                }
                if let safeData = data {
                    if let story = self.parseJson(safeData) {
                        print("Safe Data")
                        self.delegate?.didUpdateStory(story: story)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(_ storyData: Data) -> StoryInfo? {
        print("parseJson Started....!")
        let decoder = JSONDecoder()
        do {
            print("DecodeData")
            let decodeData = try decoder.decode(StoryInfo.self, from: storyData)
            return decodeData
        } catch {
            print(error)
            delegate?.didFailWithError(error: "error")
            return nil
        }
    }
}
