//
//  CustomListDetailViewController.swift
//  UpcomingMovies
//
//  Created by Alonso on 4/19/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UIKit

class CustomListDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CustomListDetailViewModel? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
