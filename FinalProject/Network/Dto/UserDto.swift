//
//  UserDto.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation

struct UserDto: Codable {
    let id: String
    let username: String
    let name: String
    let location: String?
    let profile_image: ProfileImageDto
}

struct ProfileImageDto: Codable {
    let small: String
    let medium: String
    let large: String
}
