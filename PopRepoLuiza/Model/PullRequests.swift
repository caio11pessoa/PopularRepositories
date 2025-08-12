//
//  PullRequests.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation

struct PullRequest: Codable {
    var html_url: String
    var title: String
    var user: User
    var body: String?
    var created_at: String
}

struct User: Codable {
    var login: String
    var avatar_url: String
}
