//
//  AnyBindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 2/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

final class AnyBindable<T>: Bindable {

    typealias Model = T
    typealias Listener = ((T) -> Void)

    private let bindClosure: ((@escaping Listener, DispatchQueue?) -> Void)
    private let bindAndFireClosure: ((@escaping Listener, DispatchQueue?) -> Void)

    init<B: Bindable>(_ bindable: B) where B.Model == T {
        self.bindClosure = bindable.bind
        self.bindAndFireClosure = bindable.bindAndFire
    }

    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue?) {
        bindClosure(listener, dispatchQueue)
    }

    func bindAndFire(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue?) {
        bindAndFireClosure(listener, dispatchQueue)
    }

}
