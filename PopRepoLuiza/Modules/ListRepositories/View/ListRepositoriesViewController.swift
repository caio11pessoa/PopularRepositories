//
//  HomeViewController.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit
import RxSwift
import RxCocoa


class ListRepositoriesViewController: AbstractViewController {
    var viewModel: ListRepositoriesViewModel = ListRepositoriesViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(repositoryListCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    let navigationAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        return appearance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        subViews()
        constraints()
        viewModel.setupPageBinding()
        viewModel.setupRepositoriesBinding(tableView: tableView)
        viewModel.setupTableViewBindings(tableView: tableView, viewController: self)
        viewModel.setupLoadingBindings(loadingIndicator: loadingIndicator)
        viewModel.fetchRepositories()
        viewModel.setupViewError(viewController: self) {
            self.viewModel.fetchRepositories()
        }
    }
    
    func setupNavigation(){
        title = "Github SwiftPop"
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.navigationBar.standardAppearance = navigationAppearance
    }
    
    func subViews(){
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
