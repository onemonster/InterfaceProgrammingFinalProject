//
//  Config.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation

class Config {
    static let shared = Config()

    private init() {
        let dictPath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configDict = NSDictionary(contentsOfFile: dictPath!)!
        baseUrl = configDict.object(forKey: "BASE_URL") as! String
        clientId = configDict.object(forKey: "CLIENT_ID") as! String
    }

    let baseUrl: String
    let clientId: String
}
