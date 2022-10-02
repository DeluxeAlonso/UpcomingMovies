//
//  Bindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Foundation

protocol Bindable {

    associatedtype Model

    func bind(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)
    func bindAndFire(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)

}
