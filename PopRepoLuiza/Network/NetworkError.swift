//
//  NetworkError.swift
//  PopRepoLuiza
//
//  Created by Caio de Almeida Pessoa on 12/08/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case unauthorized
    case forbidden
    case notFound
    case serverError(code: Int)
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidResponse:
            return "Resposta inválida do servidor"
        case .noData:
            return "Nenhum dado recebido"
        case .unauthorized:
            return "Acesso não autorizado"
        case .forbidden:
            return "Acesso proibido"
        case .notFound:
            return "Recurso não encontrado"
        case .serverError(let code):
            return "Erro no servidor (código: \(code))"
        case .httpError(let statusCode, _):
            return "Erro HTTP: \(statusCode)"
        case .decodingError(let error):
            return "Erro ao decodificar dados: \(error.localizedDescription)"
        case .unknown(let error):
            return "Erro desconhecido: \(error.localizedDescription)"
        }
    }
    
    static func map(_ error: Error) -> NetworkError {
        switch error {
        case let error as URLError where error.code == .notConnectedToInternet:
            return .noData
        case let error as NetworkError:
            return error
        default:
            return .unknown(error)
        }
    }
}
