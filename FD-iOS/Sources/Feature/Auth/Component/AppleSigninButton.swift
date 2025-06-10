import SwiftUI
import AuthenticationServices

struct AppleSigninButton : View {
    private var action: (AppleSigninRequestParameter) -> Void
    private let keychain = KeychainImpl()
    @State private var requestData: AppleSigninRequestParameter = .init(id: "", email: "", name: "")

    public init(
        action: @escaping (AppleSigninRequestParameter) -> Void
    ) {
        self.action = action
    }

    var body: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let fullName = appleIDCredential.fullName
                        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        print("name: \(name)")
                        let email = appleIDCredential.email
                        print("email: \(email ?? "")")
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        print("token: \(IdentityToken ?? "")")
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        print("code: \(AuthorizationCode ?? "")")

                        DispatchQueue.main.async {
                            requestData.id = "ForTest"
                            keychain.save(type: .userID, value: "ForTest")

                            if requestData.email == "" {
                                requestData.email = keychain.load(type: .email)
                            } else {
                                requestData.email = email ?? ""
                                keychain.save(type: .email, value: email ?? "")
                            }

                            if requestData.name == "" {
                                requestData.name = keychain.load(type: .name)
                            } else {
                                requestData.name = name
                                keychain.save(type: .name, value: name)
                            }

                            action(requestData)
                        }
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("Login Failed")
                }
            }
        )
        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
    }
}

#Preview {
    AppleSigninButton {_ in 
        print("fdjslk")
    }
}
