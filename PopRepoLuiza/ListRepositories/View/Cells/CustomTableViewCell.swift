//
//  CustomTableViewCell.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell{
    
    var repositoryName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    var repositoryDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
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
    
    private let ownerProfilePicture: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = .gray
        return iv
    }()
    
    private let ownerUsername: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    private let ownerFullname: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.gray
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
        
        let forksStack = setStack(arrangedSubviews: [forksIcon, forksCount])
        let starsStack = setStack(arrangedSubviews: [starsIcon, starsCount])
        
        let forksAndStarsStack = setStack(arrangedSubviews: [forksStack, starsStack], spacing: 12)
        
        let nameAndDescriptionStack = setStack(
            arrangedSubviews: [repositoryName, repositoryDescription], axis: .vertical)
        
        let leftStack = setStack(
            arrangedSubviews: [nameAndDescriptionStack, forksAndStarsStack], axis: .vertical, spacing: 12, alignment: .leading)
        
        let rightStack = setStack(
            arrangedSubviews: [ownerProfilePicture, ownerUsername, ownerFullname], axis: .vertical, alignment: .center)
        
        let mainStack = setStack(arrangedSubviews: [leftStack, rightStack], distribution: .equalSpacing)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        ownerProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ownerProfilePicture.widthAnchor.constraint(equalToConstant: 50),
            ownerProfilePicture.heightAnchor.constraint(equalToConstant: 50),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureCell(with repository: Repository) {
        repositoryName.text = repository.name
        repositoryDescription.text = repository.description
        ownerUsername.text = repository.owner.login
        ownerFullname.text = "Nome Sobrenome"
        forksCount.text = "\(repository.forks_count)"
        starsCount.text = "\(repository.stargazers_count)"
        ownerProfilePicture.loadRemoteImage(url: repository.owner.avatar_url)
    }
    
}
