//
//  RetryActionable.swift
//  UpcomingMovies
//
//  Created by Alonso on 5/22/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

protocol RetryActionable {

    var retry: (() -> Void)? { get set }

    func resetState()

}
