//
//  AbstractViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewModelWithPagesDisposeBagAndLoading: AbstractViewModel {
    var page = BehaviorRelay<Int>(value: 1)
    
    var isLastPage: Bool = false
}

class AbstractViewModel{
    var requestErrorMessage = BehaviorRelay<String?>(value: nil)
    var viewWithError = BehaviorRelay<Bool>(value: false)
    var isLoading = BehaviorRelay<Bool>(value: true)
    var disposeBag: DisposeBag = DisposeBag()
    func setupViewError(viewController: AbstractViewController, loadRequest: (() -> Void)? = nil){
        requestErrorMessage
            .asDriver()
            .compactMap{$0}
            .drive(onNext: { [weak viewController] errorMessage in
                viewController?.showErrorAlert(
                    title: "Erro",
                    message: errorMessage,
                    loadRequest: loadRequest
                )
            })
            .disposed(by: disposeBag)
    }

    func setupLoadingBindings(loadingIndicator: UIActivityIndicatorView){
        
        isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                if isLoading {
                    loadingIndicator.startAnimating()
                } else {
                    loadingIndicator.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }
}
