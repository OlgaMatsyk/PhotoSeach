//
//  DBManager.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/6/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import UIKit
import RealmSwift
class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() ->   Results<Photo> {
        let results: Results<Photo> =   database.objects(Photo.self)
        return results
    }
    func addData(object: Photo)   {
        try! database.write {
            database.add(object, update: .all)
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    func deleteFromDb(object: Photo)   {
        try!   database.write {
            database.delete(object)
        }
    }
}
