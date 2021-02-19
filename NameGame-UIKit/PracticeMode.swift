//
//  PracticeMode.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/18/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class PracticeMode: UIViewController {
    
    var employees: [Employee] = []
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        API.getEmployees { (data, error) in
            guard let data = data, error == nil else {
                //Present error alert, incl. pop to home view
                return
            }
            self.employees += data
            DispatchQueue.main.async {
                //Setup collectionView here once done loading data
                print(self.employees[0].firstName)
            }
        }
    }
}
