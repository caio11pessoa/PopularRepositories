//
//  MockURLProtocol.swift
//  PopRepoLuizaTests
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import UIKit

class MockTableView: UITableView {
    var mockNumberOfSections = 1
    var mockNumberOfRowsInSection = [Int: Int]()
    
    override var numberOfSections: Int {
        return mockNumberOfSections
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return mockNumberOfRowsInSection[section] ?? 0
    }
}
