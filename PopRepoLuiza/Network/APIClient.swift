//
//  APIClient.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation
import RxCocoa
import RxSwift

class APIClient {
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)
    
    func getSwiftPopRepositories(page: String = "1") throws -> Observable<RepositoryModel> {
        
        let components = createComponents(
            pathComponents: ["search", "repositories"],
            queryItems: [
                .init(name: "q", value: "language:Swift"),
                .init(name: "sort", value: "stars"),
                .init(name: "page", value: page)
            ]
        )
        
        let request = URLRequest(url: components.url!)
        
        return requestObservable.callAPI(request: request)
    }
    
    func getPullRequest(for repository: String, user: String, page: String = "1") throws -> Observable<[PullRequest]> {
        let components = createComponents(pathComponents: ["repos", user, repository, "pulls"], queryItems: [.init(name: "page", value: page)])
        let request = URLRequest(url: components.url!)

        return requestObservable.callAPI(request: request)
    }
    
    private func createComponents(scheme: String = "https", host: String =  "api.github.com", pathComponents: [String], queryItems: [URLQueryItem]? = nil) -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = "/" + pathComponents.joined(separator: "/")
        components.queryItems = queryItems
        
        return components
    }
    
    //    func createQueryItems(for parameters: [String: Any]) -> [URLQueryItem] {
    //        return parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    //    }
}
