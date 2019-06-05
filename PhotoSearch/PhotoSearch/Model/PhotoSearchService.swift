//
//  PhotoSearchManager.swift
//  PhotoSearch
//
//  Created by Olga Matsyk on 6/5/19.
//  Copyright © 2019 Matsyk. All rights reserved.
//

import UIKit

class PhotoSearchService {
    
    let host = "https://giphy.p.rapidapi.com"
    let apiMethod = "/v1/gifs/search"
    let key: String
    let rapidApiKey: String
    
    init(key: String, rapidApiKey: String) {
        self.key = key
        self.rapidApiKey = rapidApiKey
    }

    // Find photos, results are returned asynchronously via the supplied callback
    func findPhotos(query: String, callback: @escaping (Result<PhotoArray>) -> ())  {
        
        // convert the PhotoQuery into querystring parameters
        let params = [
            "q": query,
            "api_key": self.key
        ];
        
        let querystring = params.map { key, value in "\(key)=\(value)" }
            .joined(separator:"&");
        
        // construct the query URL
        guard let url = URL(string: "\(host)\(apiMethod)?\(querystring)") else {
            callback(.Error(PhotoSearchError.MalformedRequest))
            return
        }
        // perform the request
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.rapidApiKey, forHTTPHeaderField: "X-RapidAPI-Key")

        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            // dispatch onto the main thread
            DispatchQueue.main.async {
                do {
                    // parse the results
                    let result = try self.parseSearchResults(data: data!)
                    
                    callback(Result.Success(result))
                } catch {
                    callback(Result.Error(PhotoSearchError.ParseError))
                }
            }
        }
        
        task.resume()
    }
    
    // parses the JSON data
    private func parseSearchResults(data: Data) throws -> PhotoArray {
        
        // convert the JSON response into a dictionary
        guard
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary,
            let photos = jsonDict["data"] as? [NSDictionary] else {
                throw PhotoSearchError.ParseError
        }
        
        let parsedPhotos = photos.map {
            photoDict -> Photo? in
            // parse each photo instance - if an error occurs, return nil
            let images = photoDict["images"] as? NSDictionary
            let still = images?["480w_still"] as? NSDictionary

            guard let imageUrl = still?["url"] as? String,
                let name = still?["url"] as? String,
                let url = URL(string: imageUrl) else {
                    return nil
                }
            
                return Photo(title: name, url: url)
            }
            // unwrap optionals and remove nils
            .compactMap { return $0! }
        
        return parsedPhotos;
    }
    

}
