//
//  Users.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import Foundation

// MARK: - User

struct User: Codable {
    let id: Int64
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo

struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company

struct Company: Codable {
    let name, catchPhrase, bs: String
}

typealias Users = [User]
