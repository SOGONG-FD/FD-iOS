import Foundation

import RxSwift
import RxCocoa

import Moya
import RxMoya

class BaseNetwork<API: FDAPI> {
    private let keychain: any Keychain

    private let provider: MoyaProvider<API>

    init(keychain: any Keychain) {
        self.keychain = keychain
        self.provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    }

    func request(_ api: API) -> Single<Response> {
        return .create { single in
            var disposables: [Disposable] = []
            disposables.append(
                    self.defaultRequest(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) }
                        )
                )
            return Disposables.create(disposables)
        }
    }
}

private extension BaseNetwork {
    func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx
            .request(api)
            .timeout(.seconds(120), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let code = (error as? MoyaError)?.response?.statusCode else {
                    return .error(error)
                }
                return .error(
                    api.errorMap?[code] ??
                    FDError.error(
                        message: (try? (error as? MoyaError)?
                            .response?
                            .mapJSON() as? NSDictionary)?["message"] as? String ?? "",
                        errorBody: [:]
                    )
                )
            }
    }
    
//    func isApiNeedsAccessToken(_ api: API) -> Bool {
//        return api.fdHeader == .accessToken
//    }
}
