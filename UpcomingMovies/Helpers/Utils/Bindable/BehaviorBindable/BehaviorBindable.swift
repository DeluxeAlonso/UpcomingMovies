//
//  BehaviorBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

final class BehaviorBindable<T>: BehaviorBindableProtocol {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var dispatchQueue: DispatchQueue?

    var value: T {
        didSet {
            sendValue()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    func bindAndFire(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
        sendValue()
    }

    // MARK: - Private

    private func sendValue() {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(self.value) }
        } else {
            self.listener?(self.value)
        }
    }

}
