//
//  API.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import Foundation

class API {
    
    static let baseURL = "https://namegame.willowtreeapps.com/api/v1.0/profiles"
    
    static func getEmployees(_ completion: @escaping ([Employee]?, Error?) -> Void) {
        let url = URL(string: baseURL)!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode([Employee].self, from: data)
                completion(jsonData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
