//
//  Posts.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation

// MARK: - Post

struct Post: Codable, Hashable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body
    }
}

typealias Posts = [Post]
