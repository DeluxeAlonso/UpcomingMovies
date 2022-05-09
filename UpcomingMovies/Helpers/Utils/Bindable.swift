//
//  Bindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

final class Bindable<T> {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var deliverOnMainThread = false

    var value: T {
        didSet {
            sendValue()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?, onMainThread: Bool = false) {
        self.listener = listener
        self.deliverOnMainThread = onMainThread
    }

    func bindAndFire(_ listener: Listener?, onMainThread: Bool = false) {
        self.listener = listener
        self.deliverOnMainThread = onMainThread
        sendValue()
    }

    // MARK: - Private

    private func sendValue() {
        if deliverOnMainThread {
            DispatchQueue.main.async { self.listener?(self.value) }
        } else {
            listener?(value)
        }
    }

}
