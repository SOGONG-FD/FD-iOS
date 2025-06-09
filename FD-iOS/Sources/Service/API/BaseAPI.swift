import Foundation

import Moya

public protocol FDAPI: TargetType {
    associatedtype ErrorType: Error
    var domain: FDDomain { get }
    var urlPath: String { get }
    var fdHeader: TokenType { get }
    var errorMap: [Int: ErrorType]? { get }
}

public extension FDAPI {
    var baseURL: URL {
        switch domain {
        case .auth, .posts:
            URL(string: "http://54.180.228.203:5000")!
        case .ai:
            URL(string: "http://54.180.228.203:8000")!
        }
    }

    var path: String {
        domain.URLString + urlPath
    }

    var headers: [String: String]? {
        switch fdHeader {
        case .accessToken:
            return JwtStore.shared.toHeader(.accessToken)
        case .refreshToken:
            return JwtStore.shared.toHeader(.refreshToken)
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

public enum FDDomain: String {
    case auth
    case ai
    case posts

    var URLString: String {
        return "/\(self.rawValue)"
    }
}

public enum TokenType: String {
    case accessToken
    case refreshToken
    case tokenIsEmpty

    var toHeader: [String: String] {
        switch self {
        case .accessToken:
            return JwtStore.shared.toHeader(.accessToken)
        case .refreshToken:
            return JwtStore.shared.toHeader(.refreshToken)
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        }
    }

}
