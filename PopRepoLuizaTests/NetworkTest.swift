//
//  tete.swift
//  PopRepoLuizaTests
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import Quick
import Nimble
@testable import PopRepoLuiza

class URLComponentsCreationSpec: QuickSpec {
    override class func spec() {
        var apiClient: APIClient!
        
        beforeEach {
            apiClient = APIClient()
        }
        
        describe("createComponents from APIClient") {
            
            context("with few parameters an") {
                it("should create components with default scheme and host") {
                    let path = ["users", "octocat"]
                    let components = apiClient.createComponents(pathComponents: path)
                    
                    expect(components.scheme) == "https"
                    expect(components.host) == "api.github.com"
                    expect(components.path) == "/users/octocat"
                    expect(components.queryItems).to(beNil())
                }
            }
            
            context("with custom scheme and host") {
                it("should use the provided scheme and host") {
                    let path = ["repos", "apple", "swift"]
                    let components = apiClient.createComponents(
                        scheme: "http",
                        host: "api.example.com",
                        pathComponents: path
                    )
                    
                    expect(components.scheme) == "http"
                    expect(components.host) == "api.example.com"
                    expect(components.path) == "/repos/apple/swift"
                }
            }
            
            context("with query items") {
                it("should include the query items in the components") {
                    let path = ["search", "repositories"]
                    let queryItems = [
                        URLQueryItem(name: "q", value: "language:swift"),
                        URLQueryItem(name: "sort", value: "stars")
                    ]
                    
                    let components = apiClient.createComponents(
                        pathComponents: path,
                        queryItems: queryItems
                    )
                    
                    expect(components.queryItems).toNot(beNil())
                    expect(components.queryItems?.count) == 2
                    expect(components.queryItems?.first?.name) == "q"
                    expect(components.queryItems?.first?.value) == "language:swift"
                    expect(components.queryItems?.last?.name) == "sort"
                    expect(components.queryItems?.last?.value) == "stars"
                }
            }
            
            context("with empty path components") {
                it("should create components with just a slash") {
                    let components = apiClient.createComponents(pathComponents: [])
                    
                    expect(components.path) == "/"
                }
            }
            
            context("with path components containing slashes") {
                it("should properly join the components") {
                    let path = ["users/", "/octocat/", "/repos"]
                    let components = apiClient.createComponents(pathComponents: path)
                    
                    expect(components.path) == "/users///octocat///repos"
                }
            }
            
            context("with empty query items array") {
                it("should not include query items") {
                    let path = ["users"]
                    let components = apiClient.createComponents(
                        pathComponents: path,
                        queryItems: []
                    )
                    
                    expect(components.queryItems).to(beEmpty())
                }
            }
        }
    }
}
