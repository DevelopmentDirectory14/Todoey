//
//  Item.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/13/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = true
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
