//
//  ErrorHandler.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import Foundation

protocol ErrorHandler {
    func errorHandler(for error: Error) -> String
}

extension ErrorHandler {
    func errorHandler(for error: Error) -> String {
        
        let nsError = error as NSError
        switch nsError.code {
            
        case NSURLErrorUnknown:
            return "Erro Deseconhecido"
        case NSURLErrorBadURL:
            return "URL com erro"
        case NSURLErrorTimedOut:
            return "A requisição demorou muito para responder."
        case 404:
            return "Recurso não encontrado."
        default:
            return nsError.localizedDescription
        }
    }
}
