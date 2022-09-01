//
//  ConfigurationClientProtocol.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 12/23/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

protocol ConfigurationClientProtocol {

    func getImagesConfiguration(completion: @escaping (Result<ImagesConfigurationResult, APIError>) -> Void)

}
