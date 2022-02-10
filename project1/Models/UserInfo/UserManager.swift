//
//  UserManager.swift
//  project1
//
//  Created by karmaln technology on 04/02/22.
//

import Foundation

protocol UserInfoManagerDelegate {
    func didUpdateUser(user: UserInfo)
    func didFailWithError(error: String)
}

struct UserInfoManager {
    var delegate: UserInfoManagerDelegate?

    func fetchUserInfo() {
//        print("Fatching Started....!")
        let userCount = "50"
        let apiURl = "https://randomuser.me/api/?results=" + userCount
        perform(with: apiURl)
    }

    func perform(with urlString: String) {
        print("Perform Started....!")
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: "error!")
                    return
                }
                if let safeData = data {
                    if let user = self.parseJson(safeData) {
//                        print("Updateing User Now...!")
                        self.delegate?.didUpdateUser(user: user)

                    }
                }
            }
            task.resume()
        }

//        print("\n\n-------UserData-------\n\n")
    }

    func parseJson(_ userData: Data) -> UserInfo? {
//        print("parseJson Started....!")
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(UserInfo.self, from: userData)
            delegate?.didUpdateUser(user: decodeData)
            return decodeData
        } catch {
            print(error)
            delegate?.didFailWithError(error: "error")
            return nil
        }
    }
}
