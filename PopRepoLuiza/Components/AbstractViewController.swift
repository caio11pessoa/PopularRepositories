//
//  AbstractViewController.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//


import UIKit
import RxSwift
import RxCocoa

class AbstractViewController: UIViewController {
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = self.view.center
        loadingIndicator.hidesWhenStopped = true
        return loadingIndicator
    }()
    
    func showErrorAlert(title: String = "Erro",
                       message: String = "Message Erro",
                       loadRequest: (() -> Void)? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            if let loadRequest = loadRequest {
                alert.addAction(UIAlertAction(
                    title: "Tentar Novamente",
                    style: .default,
                    handler: { _ in loadRequest() }
                ))
            }
            
            alert.addAction(UIAlertAction(
                title: "Fechar",
                style: .cancel
            ))
            
            self.present(alert, animated: true)
        }
    }
}
