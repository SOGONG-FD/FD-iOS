import SwiftUI

import RxSwift
import RxCocoa

struct MyPageView: View {
    private let disposeBag = DisposeBag()
    private let keychain = KeychainImpl()

    @State private var promptHistory: [PromptHistoryResponseElement]?

    var body: some View {
//        NavigationStack {
            VStack {
                Text("조영준")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text("cyj070513@gmail.com")
                    .font(.caption)
                    .tint(.gray)
                Image.profileIcon
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                Spacer()
            }
            .padding(.top, 32)
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

#Preview {
    MyPageView()
}
