//
//  UnsplashApi.swift
//  FinalProject
//
//  Created by 조일현 on 2021/12/12.
//

import Foundation
import Alamofire

enum UnsplashApi: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: Config.shared.baseUrl + path)!)
        request.method = self.method
        request = try Alamofire.URLEncoding.queryString.encode(request, with: self.queries)
        request.addValue("Client-ID \(Config.shared.clientId)", forHTTPHeaderField: "Authorization")
        return request
    }

    case getPhotos(page: Int)
    case searchPhotos(query: String, page: Int)
    
    var path: String {
        switch self {
        case .getPhotos: return "/photos"
        case .searchPhotos: return "/search/photos"
        }
    }
    
    var queries: [String: Any]? {
        switch self {
        case let .getPhotos(page): return ["page": page]
        case let .searchPhotos(query, page): return ["query": query, "page": page]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos: return .get
        case .searchPhotos: return .get
        }
    }
}
