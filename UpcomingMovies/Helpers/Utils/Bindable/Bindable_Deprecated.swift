//
//  Bindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/5/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Dispatch

@available(*, deprecated, message: "Deprecated. Use PublishBindable or BehaviorBindable instead.")
final class Bindable_Deprecated<T> {

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
