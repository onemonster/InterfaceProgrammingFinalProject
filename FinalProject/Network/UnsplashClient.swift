//
//  UnsplashClient.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation
import Alamofire
import Combine

class UnsplashClient {
    static let shared = UnsplashClient()

    private init() {}

    func getPhotos(page: Int) -> AnyPublisher<[Photo], AFError> {
        return AF.request(UnsplashApi.getPhotos(page: page))
            .publishDecodable(type: [PhotoDto].self)
            .value()
            .map { $0.compactMap { dto in dto.toModel() } }
            .eraseToAnyPublisher()
    }

    func searchPhotos(query: String, page: Int) -> AnyPublisher<[Photo], AFError> {
        return AF.request(UnsplashApi.searchPhotos(query: query, page: page))
            .publishDecodable(type: [PhotoDto].self)
            .value()
            .map { $0.compactMap { dto in dto.toModel() } }
            .eraseToAnyPublisher()
    }
}
