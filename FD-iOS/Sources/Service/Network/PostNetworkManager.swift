import Foundation

import Moya
import RxMoya

import RxSwift
import RxCocoa


class PostNetworkManager : BaseNetwork<PostAPI> {
    static let shared = PostNetworkManager(keychain: KeychainImpl())

    func createPost(req: CreatePostParams) -> Single<PostCreateSuccessResponse> {
        return request(.createPost(req: req))
            .filterSuccessfulStatusCodes()
            .map(PostCreateSuccessResponse.self)
            .map { return $0 }
            .catch { error in
                print(error.localizedDescription)
                return .never()
            }
    }

    func getPost() -> Single<[PostResponseElement]> {
        return request(.getPost)
            .filterSuccessfulStatusCodes()
            .map(AllPostResponse.self)
            .map {
                return $0.posts
            }
            .catch { error in
                print(error.localizedDescription)
                return .never()
            }
    }
    func getDetailPost(id: String) -> Single<PostResponseElement> {
        return request(.getDetailPost(id: id))
            .filterSuccessfulStatusCodes()
            .map(PostResponse.self)
            .map {
                return $0.post
            }
            .catch { error in
                print(error.localizedDescription)
                return .never()
            }
    }
    func deletePost(id: String) -> Single<Bool> {
        return request(.deletePost(id: id))
            .filterSuccessfulStatusCodes()
            .map {
                switch $0.statusCode {
                case 200...299:
                    return true
                default:
                    return false
                }
            }
            .catch { error in
                print(error.localizedDescription)
                return .just(false)
            }
    }
}
