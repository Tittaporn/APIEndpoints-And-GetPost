//
//  ServiceController.swift
//  Networking
//
//  Created by Lee on 8/5/21.
//

import Foundation

/*
 GET Posts ==> https://jsonplaceholder.typicode.com/posts
 GET Post Comments ==> https://jsonplaceholder.typicode.com/comments?postId=1
 POST Post ==>  https://jsonplaceholder.typicode.com/posts
 */

enum PostServiceEndPoint {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    case getPosts
    case getPostComments(postId: String)
    case postPost
    case testEndPoint(test: String, testId: String, propertyId: String)
   
    var path: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getPostComments( _):
            return "comments"
        case .postPost:
            return "posts"
        case .testEndPoint(test: _, testId: _, propertyId: _):
            return "test"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        switch self {
        case .getPosts:
            return items
        case .getPostComments(let postId):
            items.append(URLQueryItem(name: "postId", value: postId))
            return items
        case .postPost:
            return items
        case .testEndPoint(let test, let testId, let propertyId):
            items.append(URLQueryItem(name: "test", value: test))
            items.append(URLQueryItem(name: "testId", value: testId))
            items.append(URLQueryItem(name: "propertyId", value: propertyId))
            return items
        }
    }
    
    var url: URL? {
        guard var url = URL(string: PostServiceEndPoint.baseURL) else { return nil }
        url.appendPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        print("=================== Final URL : \(components?.url)====================== \(#function) -- \(#file) -- \(#line)")
        return components?.url
    }
}

