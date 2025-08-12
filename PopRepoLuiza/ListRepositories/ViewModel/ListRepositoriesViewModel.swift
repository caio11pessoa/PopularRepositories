//
//  ListRepositoriesViewModel.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation
import RxSwift
import RxCocoa

class ListRepositoriesViewModel: ViewModelWithPagesDisposeBagAndLoading {
    
    var repositories = BehaviorRelay<[Repository]>(value: [])
    
    func setupBindings(tableView: UITableView, viewController: UIViewController){
        setupPageBinding()
        setupRepositoriesBinding(tableView: tableView)
        setupTableViewBindings(tableView: tableView, viewController: viewController)
    }
    
    func fetchRepositories(){
        let client = APIClient.shared
        do {
            try client.getSwiftPopRepositories(page: "\(self.page.value)")
                .subscribe(
                    onNext: onNextfetchRepositories,
                    onError: onErrorfetchRepositories,
                    onCompleted: onCompletedfetchRepositories
                )
                .disposed(by: disposeBag)
        } catch {
            catchFetchRepositories(error: error)
        }
    }
    
    func setupPageBinding(){
        page
            .skip(1)
            .subscribe(onNext: onNextSetupPageBinding).disposed(by: disposeBag)
    }
    
    func setupRepositoriesBinding(tableView: UITableView){
        repositories
            .bind(to: tableView.rx.items(cellIdentifier: "CustomCell", cellType: repositoryListCell.self)) { row, model, cell in
                cell.configureCell(with: model)
            }
            .disposed(by: disposeBag)
    }
    
    func setupInfinitScrollBinding(tableView: UITableView){
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] _, indexPath in
                guard let self = self else { return }
                
                let isLastCell = self.isLastCell(indexPath: indexPath, tableView: tableView)
                if isLastCell {
                    self.loadNextPage()
                }
            }).disposed(by: disposeBag)
    }
    
    func setupItemSelectionBinding(tableView: UITableView, viewController: UIViewController){
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                self.navigateToPullRequests(for: indexPath, from: viewController)
                
            })
            .disposed(by: disposeBag)
    }
    
    func setupTableViewBindings(tableView: UITableView, viewController: UIViewController){
        
        setupInfinitScrollBinding(tableView: tableView)
        setupItemSelectionBinding(tableView: tableView, viewController: viewController)
        
    }
    
    internal func onNextfetchRepositories(result: RepositoryModel) {
        if(self.verifyEmptyDataSource(result: result)){
            self.requestErrorMessage.accept("Nenhum resultado foi encontrado")
        } else{
            self.repositories.accept(repositories.value + result.items)
        }
    }
    
    internal func onErrorfetchRepositories(error: any Error){
        let message = error.localizedDescription
        self.requestErrorMessage.accept(message)
    }
    
    internal func onCompletedfetchRepositories(){
        self.isLoading.accept(false)
    }
    
    internal func catchFetchRepositories(error: any Error){
        let message = "Erro inesperado: \(error.localizedDescription)"
        requestErrorMessage.accept(message)
        self.isLoading.accept(false)
    }
    
    internal func onNextSetupPageBinding(_: Int){
        self.fetchRepositories()
    }
    
    internal func navigateToPullRequests(for indexPath: IndexPath, from viewController: UIViewController){
        let repository = self.repositories.value[indexPath.row]
        let pullRequestViewController = ListPullRequestViewController()
        
        pullRequestViewController.viewModel.userName = repository.owner.login
        pullRequestViewController.viewModel.repositoryName = repository.name
        
        viewController.navigationController?.pushViewController(pullRequestViewController, animated: true)
    }
    
    internal func loadNextPage() {
        isLoading.accept(true)
        page.accept(page.value + 1)
    }
    
    internal func isLastCell(indexPath: IndexPath, tableView: UITableView) -> Bool {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        return indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex
    }
    
    internal func verifyEmptyDataSource(result: RepositoryModel) -> Bool {
        return result.total_count == 0 && page.value == 1
    }
    
}

