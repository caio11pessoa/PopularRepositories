//
//  CustomListPullRequestCell.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

class CustomListPullRequestCell: AbstractCell {
    
    private let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        // Configura avatar
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicture.widthAnchor.constraint(equalToConstant: 30),
            profilePicture.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Monta stack de username + avatar
        nameStack.addArrangedSubview(profilePicture)
        nameStack.addArrangedSubview(userName)
        
        // Monta stack principal
        mainStack.addArrangedSubview(title)
        mainStack.addArrangedSubview(body)
        mainStack.addArrangedSubview(nameStack)
        
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    func configureCell(with pullRequest: PullRequest) {
        title.text = pullRequest.title
        body.text = pullRequest.body
        userName.text = pullRequest.user.login
        profilePicture.loadRemoteImage(url: pullRequest.user.avatar_url)
    }
}

