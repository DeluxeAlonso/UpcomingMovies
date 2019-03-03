//
//  UIViewControllerHelper.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var appDelegate: AppDelegate? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return delegate
    }
    
    var managedObjectContext: NSManagedObjectContext {
        return PersistenceManager.shared.persistentContainer.viewContext
    }
    
}
