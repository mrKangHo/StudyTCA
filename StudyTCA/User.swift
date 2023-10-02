//
//  User.swift
//  StudyTCA
//
//  Created by KANO on 10/2/23.
//

import Foundation

struct User: Codable, Equatable {
    let createdAt, name: String
    let avatar: String
    let id: String
}

typealias Users = [User]
