import Foundation

import Moya

public enum UserAPI {
    case signin(req: AppleSigninRequestParameter)
    case mypages
}

extension UserAPI: FDAPI {
    public typealias ErrorType = FDError
    
    public var domain: FDDomain {
        return .auth
    }
    
    public var urlPath: String {
        switch self {
        case .signin:
            return "/apple-login"
        case .mypages:
            return ""
        }
    }
    
    public var fdHeader: TokenType {
        switch self {
        case .signin:
            return .tokenIsEmpty
        case .mypages:
            return .accessToken
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signin:
            return .post
        case .mypages:
            return .get
        }
    }

    public var task: Moya.Task {
        switch self {
        case .signin(let req):
            return .requestJSONEncodable(req)
        case .mypages:
            return .requestPlain
        }
    }

    public var errorMap: [Int : FDError]? {
        return nil
    }

}
