//
//  CustomTableViewCell.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

class repositoryListCell: AbstractCell {
    
    private let forksIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "tuningfork"))
        iv.tintColor = UIColor.systemOrange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let forksCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemOrange
        return label
    }()
    
    private let starsIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "star.fill"))
        iv.tintColor = UIColor.systemOrange
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let starsCount: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemOrange
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // TODO: HStack e VStack kkkkk dá pra fazer
        let forksStack = setStack(arrangedSubviews: [forksIcon, forksCount])
        let starsStack = setStack(arrangedSubviews: [starsIcon, starsCount])
        
        let forksAndStarsStack = setStack(arrangedSubviews: [forksStack, starsStack], spacing: 12)
        
        let nameAndDescriptionStack = setStack(
            arrangedSubviews: [title, body], axis: .vertical)
        
        let leftStack = setStack(
            arrangedSubviews: [nameAndDescriptionStack, forksAndStarsStack], axis: .vertical, spacing: 12, alignment: .leading)
        
        let rightStack = setStack(
            arrangedSubviews: [profilePicture, userName], axis: .vertical, alignment: .center)
        
        let mainStack = setStack(arrangedSubviews: [leftStack, rightStack], distribution: .equalSpacing)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicture.widthAnchor.constraint(equalToConstant: 50),
            profilePicture.heightAnchor.constraint(equalToConstant: 50),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureCell(with repository: Repository) {
        title.text = repository.name
        body.text = repository.description
        userName.text = repository.owner.login
        forksCount.text = "\(repository.forks_count)"
        starsCount.text = "\(repository.stargazers_count)"
        profilePicture.loadRemoteImage(url: repository.owner.avatar_url)
    }
    
}
