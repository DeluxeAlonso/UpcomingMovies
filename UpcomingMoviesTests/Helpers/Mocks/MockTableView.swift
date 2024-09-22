//
//  MockTableView.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 22/09/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UIKit

class MockTableView: UITableView {

    private(set) var deselectRowCallCount = 0
    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        deselectRowCallCount += 1
    }

}
