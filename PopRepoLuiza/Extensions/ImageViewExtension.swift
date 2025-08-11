//
//  ImageViewExtension.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit

extension UIImageView {
    func loadRemoteImage(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: url) else {
                return
            }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
