//
//  PublishBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 25/09/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation

final class PublishBindable<T> {

    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    private var dispatchQueue: DispatchQueue?

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue
    }

    func send(_ value: T) {
        if let dispatchQueue = dispatchQueue {
            dispatchQueue.async { self.listener?(value) }
        } else {
            self.listener?(value)
        }
    }

}
