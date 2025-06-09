import Foundation

import Moya
import RxMoya

import RxSwift
import RxCocoa

class AuthNetworkManager : BaseNetwork<UserAPI> {
    static let shared = AuthNetworkManager(keychain: KeychainImpl())

    func signin(req: AppleSigninRequestParameter) -> Single<Bool> {
        return request(.signin(req: req))
            .filterSuccessfulStatusCodes()
            .map(LoginResponse.self)
            .map { response in
                JwtStore.shared.accessToken = response.token
                return true
            }
            .catch { error in
                print(error.localizedDescription)
                return .just(false)
            }
    }
}
