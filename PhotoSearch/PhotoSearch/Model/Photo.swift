//
//  Photo.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/5/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import Foundation
import RealmSwift

typealias PhotoArray = [Photo]

class Photo: Object {
    @objc dynamic var ID = 0
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}

