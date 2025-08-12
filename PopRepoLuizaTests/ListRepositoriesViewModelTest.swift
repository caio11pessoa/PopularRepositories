//
//  ListRepositoriesViewModelTest.swift
//  PopRepoLuizaTests
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import Foundation

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest
@testable import PopRepoLuiza

class ListRepositoriesViewModelTest: QuickSpec {
    override class func spec() {
        describe("ListRepositoriesViewModel") {
            var viewModel: ListRepositoriesViewModel!
            
            beforeEach {
                viewModel = ListRepositoriesViewModel()
            }
            
            describe("helper methods") {
                describe("verifyEmptyDataSource") {
                    it("should return true for empty first page") {
                        let result = RepositoryModel(total_count: 0, items: [])
                        expect(viewModel.verifyEmptyDataSource(result: result)).to(beTrue())
                    }
                    
                    it("should return false for non-empty results") {
                        let repo: Repository = .init(name: "name01", owner: .init(login: "login", avatar_url: "", url: ""), stargazers_count: 10, forks_count: 10)
                        let result = RepositoryModel(total_count: 1, items: [repo])
                        expect(viewModel.verifyEmptyDataSource(result: result)).to(beFalse())
                    }
                    
                    it("should return false for empty results on page > 1") {
                        viewModel.page.accept(2)
                        let result = RepositoryModel(total_count: 0, items: [])
                        expect(viewModel.verifyEmptyDataSource(result: result)).to(beFalse())
                    }
                }
                
                describe("isLastCell") {
                    it("should return true for last cell") {
                        
                        let mockTableView = MockTableView()
                        mockTableView.mockNumberOfSections = 1
                        mockTableView.mockNumberOfRowsInSection[0] = 5
                        
                        let lastIndexPath = IndexPath(row: 4, section: 0)
                        expect(viewModel.isLastCell(indexPath: lastIndexPath, tableView: mockTableView)).to(beTrue())
                    }
                }
            }
        }
    }
}
