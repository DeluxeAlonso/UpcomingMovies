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
