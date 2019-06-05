//
//  Result.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/5/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import Foundation

// Result of an asynchronous query
enum Result<T> {
    case Success(T)
    case Error(Error)
}
