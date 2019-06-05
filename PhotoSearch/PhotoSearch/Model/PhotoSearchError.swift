//
//  PhotoSearcherror.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/5/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import Foundation

// Errors that can occur when querying the FettyImages API
enum PhotoSearchError: Error {
    case RequestError
    case ParseError
    case MalformedRequest
}

