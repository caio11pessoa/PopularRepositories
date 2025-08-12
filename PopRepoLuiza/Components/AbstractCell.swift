//
//  CellProtocol.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

protocol CellProtocol {
    var title: UILabel { get }
    var body: UILabel { get }
    var profilePicture: UIImageView { get }
    var userName: UILabel {get}
}

class AbstractCell: UITableViewCell, CellProtocol {
    var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    var body: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    var profilePicture: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = .gray
        return iv
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemBlue
        return label
    }()
    
    
}
