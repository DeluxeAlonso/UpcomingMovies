//
//  PublishBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation

final class PublishBindable<T>: Bindable {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var dispatchQueue: DispatchQueue?

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    func bindAndFire(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue?) {
        assertionFailure("Bind and fire method is not supported for a PublishBindable")
    }

    func send(_ value: T) {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(value) }
        } else {
            self.listener?(value)
        }
    }

}
