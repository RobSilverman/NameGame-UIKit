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
    @IBOutlet var correctOverlay: UIImageView!
    @IBOutlet var incorrectOverlay: UIImageView!
    
    func getImage(from url: String, for imageSize: CGSize) {
        correctOverlay.alpha = 0
        incorrectOverlay.alpha = 0
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                guard let imageToRescale = UIImage(data: data) else { return }
                guard let rescaledImage = self.rescaleImage(imageToRescale, to: imageSize) else { return }
                self.employeeImage.image = rescaledImage
            }
        }.resume()
    }
    
    func rescaleImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let rescaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rescaledImage
    }
    
    func addCorrectOverlay() {
        correctOverlay.alpha = 0.75
    }
    
    func addIncorrectOverlay() {
        incorrectOverlay.alpha = 0.75
    }
}
