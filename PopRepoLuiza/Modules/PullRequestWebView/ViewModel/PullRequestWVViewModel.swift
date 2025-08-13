//
//  PullRequestWVViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import UIKit
import RxSwift
import RxCocoa

class PullRequestWVViewModel: AbstractViewModel {
    var urlString: String?
    
    func makeRequest() -> URLRequest? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            viewWithError.accept(true)
            isLoading.accept(false)
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
    
    func webViewWithErrorBindings(viewController: AbstractViewController){
        viewWithError
            .asDriver()
            .drive(onNext: { hasError in
                if hasError {
                    viewController.showErrorAlert(title: "Erro", message: "Ocorreu um erro ao tentar carregar a página") {
                        viewController.loadView()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
