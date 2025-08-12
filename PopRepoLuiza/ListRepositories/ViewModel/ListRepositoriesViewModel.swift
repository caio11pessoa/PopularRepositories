//
//  ListRepositoriesViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation
import RxSwift
import RxCocoa

class ListRepositoriesViewModel: ViewModelWithPagesDisposeBagAndLoading, ErrorHandler {
    var repositories = BehaviorRelay<[Repository]>(value: [])
    
    func fetchRepositories(){
        let client = APIClient.shared
        do {
            try client.getSwiftPopRepositories(page: "\(self.page.value)")
                .subscribe(
                    onNext: { result in
                        if(self.verifyEmptyDataSource(result: result)){
                            let message = "Nenhum resultado foi encontrado"
                            self.requestErrorMessage.accept(message)
                        } else{
                            self.repositories.accept(self.repositories.value + result.items)
                        }
                    },
                    onError: { error in
                        let message = self.errorHandler(for: error)
                        self.requestErrorMessage.accept(message)
                    },
                    onCompleted: {
                        self.isLoading.accept(false)
                    }
                ).disposed(by: disposeBag)
        } catch {
            let message = "Erro inesperado: \(error.localizedDescription)"
            requestErrorMessage.accept(message)
            self.isLoading.accept(false)
        }
    }
    
    func setupPageBinding(){
        page
            .skip(1)
            .map{$0}
            .subscribe(onNext: { page in
                
                self.fetchRepositories()
                
            }).disposed(by: disposeBag)
    }
    
    func setupRepositoriesBinding(tableView: UITableView){
        repositories
            .bind(to: tableView.rx.items(cellIdentifier: "CustomCell", cellType: repositoryListCell.self)) { row, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
    }
    
    func setupTableViewBindings(tableView: UITableView, viewController: UIViewController){
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { _, indexPath in
                let lastSectionIndex = tableView.numberOfSections - 1
                let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
                
                if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
                    self.isLoading.accept(true)
                    self.page.accept(self.page.value + 1)
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let repository = self.repositories.value[indexPath.row]
                
                let pullRequestVC = ListPullRequestViewController()
                pullRequestVC.viewModel.userName = repository.owner.login
                pullRequestVC.viewModel.repositoryName = repository.name
                
                viewController.navigationController?.pushViewController(pullRequestVC, animated: true)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func verifyEmptyDataSource(result: RepositoryModel) -> Bool {
        return result.total_count == 0 && page.value == 1
    }
    
}

