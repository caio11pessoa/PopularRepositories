//
//  PopRepoLuizaTests.swift
//  PopRepoLuizaTests
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import Quick
import Nimble
@testable import PopRepoLuiza

final class PopRepoLuizaTests: QuickSpec {
    override class func spec() {
        describe("Teste") {
            var test: String!

            beforeEach {
                test = "10"
            }

            it("deve ter o valor 10") {
                expect(test).to(equal("10"))
            }
        }
    }
}
