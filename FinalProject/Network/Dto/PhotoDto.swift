//
//  PhotoDto.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation

struct PhotoDto: Codable {
    let id: String
    let user: UserDto
    let urls: UrlsDto
}

extension PhotoDto {
    func toModel() -> Photo {
        let user = User(id: self.user.id, name: self.user.name, location: self.user.location, profileImageUrl: "")
        return Photo(id: self.id, user: user, thumbnailUrl: self.urls.thumb, regularUrl: self.urls.regular)
    }
}

struct UrlsDto: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
