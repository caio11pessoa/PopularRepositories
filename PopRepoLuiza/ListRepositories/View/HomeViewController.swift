//
//  HomeViewController.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import UIKit


class HomeViewController: UIViewController {
    var viewModel: ListRepositoriesViewModel = ListRepositoriesViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Componentizar
        title = "Github SwiftPop"
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        appearence.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
            navigationController?.navigationBar.standardAppearance = appearence
            navigationController!.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
        subViews()
        constraints()
    }
}

extension HomeViewController {
    func subViews(){
        view.addSubview(tableView)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: viewModel.repositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Célula clicada \(viewModel.repositories[indexPath.row].name)")
    }
    
}
