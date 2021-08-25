//
//  Post.swift
//  Networking
//
//  Created by Lee on 8/5/21.
//

import Foundation

struct Post: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

struct PostComment: Codable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
