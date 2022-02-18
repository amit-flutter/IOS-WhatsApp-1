//
//  userProfileDataRealm.swift
//  project1
//
//  Created by karmaln technology on 17/02/22.
//

import Foundation
import RealmSwift

class userData: Object {
    @objc dynamic var nikeName: String = ""
    @objc dynamic var hobbies: String = ""
    @objc dynamic var skills: String = ""
    @objc dynamic var friends: String = ""
}
