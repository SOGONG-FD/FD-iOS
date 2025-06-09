import Foundation

import Moya

public enum PromptAPI {
    case chat(id: String, message: String)
    case history(id: String, skip: Int, limit: Int)
}

extension PromptAPI: FDAPI {
    public typealias ErrorType = FDError
    
    public var domain: FDDomain {
        return .ai
    }
    
    public var urlPath: String {
        switch self {
        case let .chat(id, _):
            return "/chat/\(id)"
        case let .history(id, _, _):
            return "/history/\(id)"
        }
    }
    
    public var fdHeader: TokenType {
        switch self {
        default:
            return .tokenIsEmpty
        }
    }

    public var method: Moya.Method {
        switch self {
        case .chat:
            return .post
        case .history:
            return .get
        }
    }

    public var task: Moya.Task {
        switch self {
        case let .chat(_, message):
            return .requestParameters(
                parameters: [
                    "message": message
                ], encoding: URLEncoding.queryString)
        case let .history(_, skip, limit):
            return .requestParameters(
                parameters: [
                    "skip": skip,
                    "limit": limit
                ], encoding: URLEncoding.queryString)
        }
    }

    public var errorMap: [Int : FDError]? {
        return nil
    }

}
