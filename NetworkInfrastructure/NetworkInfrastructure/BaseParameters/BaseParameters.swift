//
//  BaseParameters.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 5/25/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

struct BaseParameters: Decodable {

    let baseAPIURLString: String
    let keys: Keys
    
    private enum CodingKeys: String, CodingKey {
        case baseAPIURLString = "BaseAPIURLString"
        case keys = "Keys"
    }
    
}
