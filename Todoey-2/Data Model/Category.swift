//
//  Category.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/13/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var cellColor : String = "No Color"
    let items = List<Item>()
}
