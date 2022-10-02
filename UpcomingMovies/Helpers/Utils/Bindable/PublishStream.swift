//
//  PublishBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 25/09/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation

class Stream<T> {

    private var listener: ((T) -> Void)?

    func bind(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue? = nil) {
        fatalError("Bind method should be implemented in a child class")
    }

    func bindAndFire(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue?) {
        fatalError("Bind and fire method should be implemented in a child class")
    }
}

final class PublishStream<T>: Stream<T> {

    private var listener: ((T) -> Void)?

    private var dispatchQueue: DispatchQueue?

    override func bind(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    override func bindAndFire(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue?) {
        // NO-OP
    }

    func send(_ value: T) {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(value) }
        } else {
            self.listener?(value)
        }
    }

}
