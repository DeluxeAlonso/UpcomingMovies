//
//  CollapsibleHeaderViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 10/10/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import Foundation

protocol CollapsibleHeaderViewModelProtocol {

    var opened: Bool { get }
    var section: Int { get }
    var title: String { get }
    var shouldAnimate: Bool { get }

    func arrowRotationValue() -> CGFloat

}

final class CollapsibleHeaderViewModel: CollapsibleHeaderViewModelProtocol {

    let opened: Bool
    let section: Int
    let title: String
    let shouldAnimate: Bool

    init(opened: Bool, section: Int, title: String, shouldAnimate: Bool = false) {
        self.opened = opened
        self.section = section
        self.title = title
        self.shouldAnimate = shouldAnimate
    }

    func arrowRotationValue() -> CGFloat {
        opened ? CGFloat.pi / 2 : 0
    }

}
