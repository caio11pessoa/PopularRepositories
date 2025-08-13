//
//  Repository.swift
//  TestTecnicoLuizaLabs
//
//  Created by Caio de Almeida Pessoa on 09/08/25.
//

import Foundation

struct Repository: Codable {
    var name: String
    var description: String?
    var owner: Owner
    var stargazers_count: Int
    var forks_count: Int
}

struct RepositoryModel: Codable {
    var total_count: Int
    var items: [Repository]
}

struct Owner: Codable {
    var login: String
    var avatar_url: String
    var url: String
}

struct GitUser: Codable {
    var name: String?
}
