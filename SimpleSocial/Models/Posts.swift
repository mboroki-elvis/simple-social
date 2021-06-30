//
//  Posts.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation

// MARK: - Post

struct Post: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }

    let userID, id: Int64
    let title, body: String

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias Posts = [Post]
