//
//  Photo.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/5/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import Foundation

typealias PhotoArray = [Photo]

// Represents a single photo as returned by the 500px API
struct Photo {
    let title: String
    let url: URL
}
