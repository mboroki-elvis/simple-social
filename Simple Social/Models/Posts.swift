//
//  Posts.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation


// MARK: - Post
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [Post]
