//
//  PublishBindableProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 23/11/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

protocol PublishBindableProtocol {

    associatedtype Model

    func bind(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)
    func send(_ value: Model)

}

extension PublishBindableProtocol {

    func eraseToAnyBindable() -> AnyPublishBindable<Model> {
        AnyPublishBindable(self)
    }

}
