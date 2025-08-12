//
//  ListPullRequestViewController.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit
import WebKit

class ListPullRequestViewController: AbstractViewController {
    var viewModel: ListPullRequestViewModel = ListPullRequestViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomListPullRequestCell.self, forCellReuseIdentifier: "CustomPRCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchPullRequests(page: "1")

        subViews()
        constraints()

        viewModel.setupPageBinding()
        viewModel.setupPullRequestsBindings(tableView: tableView)
        viewModel.setupTableViewBindings(tableView: tableView, viewController: self)
        viewModel.setupLoadingBindings(loadingIndicator: loadingIndicator)
        viewModel.setupViewError(viewController: self)
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
