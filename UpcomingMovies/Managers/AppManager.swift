//
//  AppManager.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/8/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import UIKit

enum AppShortcutItem: String {
    
    case searchMovies
    
}

class AppManager {
    
    static let shared: AppManager = AppManager()
    
    private init() { }
    
    var genres: [Genre] = []
    
    /**
     * Get an specific genre name given its id.
     */
    func findGenre(withId id: Int) -> String {
        return genres.filter { $0.id == id }.first?.name ?? "-"
    }

}
