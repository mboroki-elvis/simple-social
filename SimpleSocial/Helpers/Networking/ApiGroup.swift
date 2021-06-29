//
//  ApiPaths.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation

enum BasePath: String {
    case base = "https://jsonplaceholder.typicode.com/"
}
enum ApiGroup {
    case posts(PostPath, String)
    case users(UserPath, String)
    case comments(CommentPath, String)
    var path: String {
        switch self {
        case .posts(let api, let id):
            return String(format: BasePath.base.rawValue + api.rawValue, arguments: [id])
        case .users(let api, let id):
            return String(format: BasePath.base.rawValue + api.rawValue, arguments: [id])
        case .comments(let api, let id):
            return String(format: BasePath.base.rawValue + api.rawValue, arguments: [id])
        }
    }
}
enum PostPath: String {
    case all = "posts"
    case single = "posts/%@"
}
enum UserPath: String {
    case all = "users"
    case single = "users/%@"
}
enum CommentPath: String {
    case all = "comments"
    case single = "posts/%@/comments"
}
