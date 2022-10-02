//
//  Bindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation

protocol Bindable {

    associatedtype T

    func bind(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue?)
    func bindAndFire(_ listener: @escaping ((T) -> Void), on dispatchQueue: DispatchQueue?)

}


//final class Bindable<T>: BindableProtocol {
//
//    typealias Listener = ((T) -> Void)
//
//    init(_ value: T) {
//        self.value = value
//    }
//
//    func bind(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
//        self.listener = listener
//        self.dispatchQueue = dispatchQueue
//    }
//
//    func bindAndFire(_ listener: @escaping Listener, on dispatchQueue: DispatchQueue? = nil) {
//        self.listener = listener
//        self.dispatchQueue = dispatchQueue
//        sendValue()
//    }
//
//    // MARK: - Private
//
//    private func sendValue() {
//        if let dispatchQueue = dispatchQueue {
//            dispatchQueue.async { self.listener?(self.value) }
//        } else {
//            self.listener?(self.value)
//        }
//    }
//
//}
//
//extension Bindable_Deprecated where T == Void {
//
//    convenience init() {
//        self.init(Void())
//    }
//
//    func fire() {
//        sendValue()
//    }
//
//}
