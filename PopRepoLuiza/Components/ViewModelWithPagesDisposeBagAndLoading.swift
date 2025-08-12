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
    var errorMessage = BehaviorRelay<String?>(value: nil)
    
    var isLastPage: Bool = false
}

class AbstractViewModel{
    var isLoading = BehaviorRelay<Bool>(value: true)
    var disposeBag: DisposeBag = DisposeBag()
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
