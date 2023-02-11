//
//  ToggleBarButtonItem.swift
//  UpcomingMovies
//
//  Created by Alonso on 7/4/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit

class ToggleBarButtonItem: UIBarButtonItem {

    private var contents: [ToggleBarButtonItemContentProtocol]
    private var currentContentIndex: Int = 0

    // MARK: - Initializers

    init(contents: [ToggleBarButtonItemContentProtocol] = []) {
        self.contents = contents
        super.init()
        configure(for: currentContentIndex)
    }

    convenience init(viewModel: ToggleBarButtonItemViewModelProtocol) {
        self.init(contents: viewModel.contents)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private

    private func configure(for contentIndex: Int) {
        guard contentIndex < contents.count else { return }

        let content = contents[contentIndex]
        switch content.display {
        case .left(let title):
            self.title = title
        case .right(let image):
            self.image = image
        }

        accessibilityLabel = content.accessibilityLabel
        accessibilityHint = content.accessibilityHint
    }

    // MARK: - Internal

    func update(with viewModel: ToggleBarButtonItemViewModelProtocol,
                resetCurrentContentIndex: Bool = true) {
        if resetCurrentContentIndex {
            currentContentIndex = 0
        }
        contents = viewModel.contents
        configure(for: currentContentIndex)
    }

    func toggle() {
        currentContentIndex += 1

        // We need to validate if the index is out of bounds or not
        if currentContentIndex >= contents.count {
            currentContentIndex = 0
        }

        configure(for: currentContentIndex)
    }

    func toggle(to index: Int) {
        currentContentIndex = index

        configure(for: currentContentIndex)
    }

}
