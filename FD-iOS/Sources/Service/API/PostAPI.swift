import Foundation

import Moya

public enum PostAPI {
    case createPost(req: CreatePostParams)
    case getPost
    case getDetailPost(id: String)
    case deletePost(id: String)
}

extension PostAPI: FDAPI {
    public typealias ErrorType = FDError
    
    public var domain: FDDomain {
        return .posts
    }
    
    public var urlPath: String {
        switch self {
        case .createPost:
            return ""
        case .getPost:
            return ""
        case .getDetailPost(let id):
            return "/\(id)"
        case .deletePost(let id):
            return "/\(id)"
        }
    }
    
    public var fdHeader: TokenType {
        switch self {
        default:
            return .accessToken
        }
    }

    public var method: Moya.Method {
        switch self {
        case .createPost:
            return .post
        case .getPost, .getDetailPost:
            return .get
        case .deletePost:
            return .delete
        }
    }

    public var task: Moya.Task {
        switch self {
        case .createPost(let req):
            return .requestJSONEncodable(req)
        default:
            return .requestPlain
        }
    }

    public var errorMap: [Int : FDError]? {
        return nil
    }

}
