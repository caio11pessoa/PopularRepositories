//
//  RequestObservable.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 11/08/25.
//

import Foundation
import RxSwift
import RxCocoa

public class RequestObservable {
    
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config:URLSessionConfiguration) {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func callAPI<ItemModel: Decodable>(request: URLRequest) -> Observable<ItemModel> {
        
        return Observable.create { observer in
            
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NetworkError.invalidResponse)
                    observer.onCompleted()
                    return
                }
                
                let statusCode = httpResponse.statusCode
                guard (200...399).contains(statusCode) else {
                    let error = NetworkError.httpError(statusCode: statusCode, data: data)
                    observer.onError(error)
                    observer.onCompleted()
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    observer.onCompleted()
                    return
                }
                
                do {
                    let objs = try self.jsonDecoder.decode(ItemModel.self, from: data)
                    observer.onNext(objs)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError(error))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
