//
//  BookRequestManager.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation
import Alamofire

public enum BookRequestManager: URLRequestConvertible {
    private struct Constants {
        static let baseURL = "https://api.itbook.store/1.0"
        static let method: HTTPMethod = .get
    }
    
    case newBooks
    case search(query: String, page: String)
    case bookDetails(String)
    
    var endPoint: String {
        switch self {
        case .newBooks: return "/new"
        case .search: return "/search/{query}/{page}"
        case .bookDetails: return "/books/{isbn13}"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(endPoint))
        request.httpMethod = Constants.method.rawValue
        
        return try URLEncoding.default.encode(request, with: nil)
    }
}