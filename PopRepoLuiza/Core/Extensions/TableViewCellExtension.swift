//
//  TableViewCellExtension.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

extension UITableViewCell {
    func setStack(
        arrangedSubviews views: [UIView],
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 2,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) -> UIStackView{
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        
        return stackView
    }
}
