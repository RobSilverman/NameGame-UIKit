//
//  EmployeeCell.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/19/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class EmployeeCell: UICollectionViewCell {
    
    @IBOutlet var employeeImage: UIImageView!
    
    func getImage(from url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.employeeImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
