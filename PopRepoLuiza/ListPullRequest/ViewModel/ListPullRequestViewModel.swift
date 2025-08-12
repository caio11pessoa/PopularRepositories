//
//  ListPullRequestViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation
import RxSwift
import RxCocoa

class ListPullRequestViewModel: ViewModelWithPagesDisposeBagAndLoading, ErrorHandler {
    
    var repositoryName: String
    var userName: String
    
    
    init(repositoryName: String = "RepositoryName", userName: String = "UserName"){
        self.repositoryName = repositoryName
        self.userName = userName
    }
    
    var pullRequests = BehaviorRelay<[PullRequest]>(value: [])
    
    func fetchPullRequests(page: String = "1"){
        
        let client = APIClient.shared
        do {
            try client.getPullRequest(for: repositoryName, user: userName, page: page)
                .subscribe(
                    onNext: { [weak self] result in
                        guard let self = self else { return }
                        if(result.isEmpty){
                            self.isLastPage = true
                        }else {
                            let currentPRs = self.pullRequests.value
                            self.pullRequests.accept(currentPRs + result)
                        }
                    },
                    onError: { [weak self] error in
                        guard let self = self else { return }
                        let message = error.localizedDescription
                        self.requestErrorMessage.accept(message)
                        self.isLoading.accept(false)
                        print(message)
                    },
                    onCompleted: {
                        self.isLoading.accept(false)
                    }
                ).disposed(by: disposeBag)
        } catch {
            let message = "Erro inesperado: \(error.localizedDescription)"
            requestErrorMessage.accept(message)
            isLoading.accept(false)
        }
    }
    
    func setupPageBinding(){
        page
            .skip(1)
            .map{$0}
            .subscribe(onNext: { page in
                
                self.fetchPullRequests(page: "\(page)")
                
            }).disposed(by: disposeBag)
    }
    
    func setupPullRequestsBindings(tableView: UITableView) {
        pullRequests
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "CustomPRCell", cellType: CustomListPullRequestCell.self)) { row, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
    }
    
    func setupTableViewBindings(tableView: UITableView, viewController: UIViewController){
        tableView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _, indexPath in
                let lastSectionIndex = tableView.numberOfSections - 1
                let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
                
                if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && !self.isLastPage {
                    self.page.accept(self.page.value + 1)
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let pullRequest = pullRequests.value[indexPath.row]
                
                let webViewController = createWebViewController(url: pullRequest.html_url)
                
                viewController.present(webViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func createWebViewController(url: String) -> PullRequestWebViewController {
        let webViewController = PullRequestWebViewController()
        webViewController.viewModel.urlString = url
        return webViewController
    }
}
