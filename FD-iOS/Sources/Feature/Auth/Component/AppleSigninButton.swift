import SwiftUI
import AuthenticationServices

struct AppleSigninButton : View {
    private var action: (AppleSigninRequestParameter) -> Void
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
                        print("email: \(email ?? "fasd")")
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        print("token: \(IdentityToken ?? "")")
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        print("code: \(AuthorizationCode ?? "")")

                        DispatchQueue.main.async {
                            requestData.id = IdentityToken ?? ""
                            requestData.email = "cyj070513@gmail.com"
                            requestData.name = "조영준"
                            action(requestData)
                        }
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
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
