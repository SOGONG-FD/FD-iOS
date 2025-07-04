import Foundation

public enum FDError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])
    case serverError
}

extension FDError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .error(message, _):
            return message
        case .serverError:
            return "서버 에러가 발생했습니다."
        }
    }
}
