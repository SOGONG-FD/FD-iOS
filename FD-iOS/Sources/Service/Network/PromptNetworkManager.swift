import Foundation

import Moya
import RxMoya

import RxSwift
import RxCocoa

class PromptNetworkManager : BaseNetwork<PromptAPI> {
    static let shared = PromptNetworkManager(keychain: KeychainImpl())

    func sendChat(id: String, message: String) -> Single<String> {
        return request(.chat(id: id, message: message))
            .filterSuccessfulStatusCodes()
            .map(PromptResponse.self)
            .map {
                return $0.botMessage
            }
            .catch { error in
                print(error.localizedDescription)
                return .never()
            }
    }

    func history(id: String) -> Single<[PromptHistoryResponseElement]> {
        return request(.history(id: id, skip: 0, limit: 10))
            .filterSuccessfulStatusCodes()
            .map(PromptHistoryResponse.self)
            .map {
                return $0.history
            }
            .catch { error in
                print(error.localizedDescription)
                return .never()
            }
    }
}
