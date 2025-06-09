import SwiftUI
import AuthenticationServices

import Moya
import RxMoya

import RxSwift
import RxCocoa

struct LoginView: View {
    @State private var navigateToHome = false

    private let disposeBag = DisposeBag()
    private let keychain = KeychainImpl()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image.onboardingIcon
                    .resizable()
                    .frame(width: 300, height: 300)
                Spacer()
                AppleSigninButton { req in
                    AuthNetworkManager.shared.signin(req: req)
                        .asObservable()
                        .bind { isNavigate in
                            navigateToHome = isNavigate
                            keychain.save(type: .userID, value: req.id)
                        }
                        .disposed(by: disposeBag)
                }
                    .padding(.bottom, 20)
            }
            .navigationDestination(
                isPresented: $navigateToHome
            ) {
                RootTabView()
            }
        }
    }
}

#Preview {
    LoginView()
}
