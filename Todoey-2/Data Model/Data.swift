//
//  Data.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/10/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
