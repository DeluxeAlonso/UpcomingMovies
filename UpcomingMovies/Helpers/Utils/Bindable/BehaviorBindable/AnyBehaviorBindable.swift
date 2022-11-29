//
//  AnyBehaviorBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 28/11/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

final class AnyBehaviorBindable<T>: BehaviorBindableProtocol {

    typealias Model = T
    typealias Listener = ((T) -> Void)

    private let valueClosure: ((T) -> Void)
    private let bindClosure: ((@escaping Listener, DispatchQueue?) -> Void)
    private let bindAndFireClosure: ((@escaping Listener, DispatchQueue?) -> Void)

    var value: T {
        didSet {
            valueClosure(value)
        }
    }

    init<B: BehaviorBindableProtocol>(_ bindable: B) where B.Model == T {
        self.bindClosure = bindable.bind
        self.bindAndFireClosure = bindable.bindAndFire

        self.value = bindable.value
        self.valueClosure = { value in
            bindable.value = value
        }
    }

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
        bindClosure(listener, dispatchQueue)
    }

    func bindAndFire(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue? = nil) {
        bindAndFireClosure(listener, dispatchQueue)
    }

}
