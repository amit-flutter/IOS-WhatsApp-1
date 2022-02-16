//
//  UserManager.swift
//  project1
//
//  Created by karmaln technology on 04/02/22.
//

import Alamofire
import Foundation

protocol ShareInfoManagerDelegateMemo {
    func didUpdateShareMeme(share: ShareMemeInfo)
    func didFailWithError(error: String)
}

protocol ShareInfoManagerDelegateJokes {
    func didUpdateShareJokes(share: ShareJokesInfo)
    func didFailWithError(error: String)
}

protocol ShareInfoManagerDelegateBooks {
    func didUpdateShareBooks(share: ShareBookInfo)
    func didFailWithError(error: String)
}

protocol ShareInfoManagerDelegateTv {
    func didUpdateShareTv(share: ShareTvInfo)
    func didFailWithError(error: String)
}

protocol ShareInfoManagerDelegateWeather {
    func didUpdateShareWeather(share: ShareWeatherInfo)
    func didFailWithError(error: String)
}

struct ShareInfoManager {
    var delegateMemo: ShareInfoManagerDelegateMemo?
    var delegateJokes: ShareInfoManagerDelegateJokes?
    var delegateBooks: ShareInfoManagerDelegateBooks?
    var delegateTv: ShareInfoManagerDelegateTv?
    var delegateWeather: ShareInfoManagerDelegateWeather?

    func fetchShareInfo(withCode apiCode: Int) {
        print("Calling Fethc ShareMemeInfo....!")
        let memeUrl: String = "https://api.imgflip.com/get_memes"
        let jokesUrl: String = "https://v2.jokeapi.dev/joke/Any?type=single"
        let bookUrl: String = "https://api.itbook.store/1.0/search/best"
        let tvUrl: String = "https://api.tvmaze.com/shows"
        let weatherUrl: String = "https://weatherdbi.herokuapp.com/data/weather/india"

        var apiUrl: String = memeUrl
        switch apiCode {
        case 01:
            apiUrl = memeUrl
            perform01(with: apiUrl)
        case 02:
            apiUrl = jokesUrl
            perform02(with: apiUrl)
        case 03:
            apiUrl = bookUrl
            perform03(with: apiUrl)
        case 04:
            apiUrl = tvUrl
            perform04(with: apiUrl)
        case 05:
            apiUrl = weatherUrl
            perform05(with: apiUrl)
        default:
            apiUrl = memeUrl
            perform01(with: apiUrl)
        }
    }

    func perform01(with urlString: String) {
        print("Performing...!01")
        AF.request(urlString)
            .responseDecodable(of: ShareMemeInfo.self) { response in
                switch response.result {
                case .success:
                    print("----------[ 01 - Meme Data Got Sccessfully & Updateing Back]-----------")
                    self.delegateMemo?.didUpdateShareMeme(share: response.value!)
                case let .failure(error):
                    print(error)
                    self.delegateMemo?.didFailWithError(error: "Error")
                }
            }
    }

    func perform02(with urlString: String) {
        print("Performing...!02")
        AF.request(urlString)
            .responseDecodable(of: ShareJokesInfo.self) { response in
                switch response.result {
                case .success:
                    print("----------[02 - Jokes Data Got Sccessfully & Updateing Back]-----------")
                    self.delegateJokes?.didUpdateShareJokes(share: response.value!)
                case let .failure(error):
                    print(error)
                    self.delegateJokes?.didFailWithError(error: "Error")
                }
            }
    }

    func perform03(with urlString: String) {
        print("Performing...!03")
        AF.request(urlString)
            .responseDecodable(of: ShareBookInfo.self) { response in
                switch response.result {
                case .success:
                    print("----------[03 - Books Data Got Sccessfully & Updateing Back]-----------")
                    self.delegateBooks?.didUpdateShareBooks(share: response.value!)
                case let .failure(error):
                    print(error)
                    self.delegateBooks?.didFailWithError(error: "Error")
                }
            }
    }

    func perform04(with urlString: String) {
        print("Performing...!04")
        AF.request(urlString)
            .responseDecodable(of: ShareTvInfo.self) { response in
                switch response.result {
                case .success:
                    print("----------[04 - Tv Data Got Sccessfully & Updateing Back]-----------")
                    self.delegateTv?.didUpdateShareTv(share: response.value!)
                case let .failure(error):
                    print(error)
                    self.delegateTv?.didFailWithError(error: "Error")
                }
            }
    }

    func perform05(with urlString: String) {
        print("Performing...!05")
        AF.request(urlString)
            .responseDecodable(of: ShareWeatherInfo.self) { response in
                switch response.result {
                case .success:
                    print("----------[05 - Weather Data Got Sccessfully & Updateing Back]-----------")
                    self.delegateWeather?.didUpdateShareWeather(share: response.value!)
                case let .failure(error):
                    print(error)
                    self.delegateWeather?.didFailWithError(error: "Error")
                }
            }
    }
}
