//
//  ListRepositoriesViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation


class ListRepositoriesViewModel {
    var repositories: [Repository] = [
        Repository(
            name: "Link Repo",
            description: "Legend of Code, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            owner: Owner(
                login: "link_dev",
                avatar_url: "",
                url: ""),
            stargazers_count: 10,
            forks_count: 3),
        Repository(
            name: "Zelda Repo",
            description: "Hyrule Scripts",
            owner: Owner(
                login: "zelda_dev",
                avatar_url: "",
                url: ""),
            stargazers_count: 12,
            forks_count: 5)
    ]
}
