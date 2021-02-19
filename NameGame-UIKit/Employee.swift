//
//  Employee.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import Foundation

struct Employee: Codable {
    var firstName: String
    var lastName: String
    var headshot: Headshot
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    struct Headshot: Codable {
        var url: URL?
    }
}
