enum NetworkError: Error {
    case invalidResponse
    case noData
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Resposta inválida do servidor"
        case .noData:
            return "Nenhum dado recebido"
        case .httpError(let statusCode, _):
            return "Erro HTTP: \(statusCode)"
        case .decodingError(let error):
            return "Erro ao decodificar resposta: \(error.localizedDescription)"
        }
    }
}