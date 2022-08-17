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
    private var dispatchQueue: DispatchQueue = .main

    var value: T {
        didSet {
            sendValue()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue ?? makeDefaultQueue()
    }

    func bindAndFire(_ listener: Listener?, on dispatchQueue: DispatchQueue? = nil) {
        self.listener = listener
        self.dispatchQueue = dispatchQueue ?? makeDefaultQueue()
        sendValue()
    }

    // MARK: - Private

    private func sendValue() {
        dispatchQueue.async { self.listener?(self.value) }
    }

    private func makeDefaultQueue() -> DispatchQueue {
        return .init(label: "\(String(describing: T.self)) - \(UUID())")
    }

}

extension Bindable where T == Void {

    func fire() {
        sendValue()
    }

}
