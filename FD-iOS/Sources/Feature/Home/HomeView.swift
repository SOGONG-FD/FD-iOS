import SwiftUI

import Moya

import RxSwift
import RxCocoa

struct HomeView: View {
    private let disposeBag = DisposeBag()
    private let keychain = KeychainImpl()

    @State private var promptText: String = ""
    @State private var promptResponse: String = ""
    @State private var promptHistory: [PromptHistoryResponseElement]?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                        ForEach(promptHistory ?? [], id: \.self) { data in
                            PromptView(
                                promptText: data.userMessage,
                                type: .user
                            )
                            PromptView(
                                promptText: data.botMessage,
                                type: .bot,
                                title: data.userMessage,
                                content: data.botMessage
                            )
                        }
                    PromptView(
                        promptText: promptText,
                        type: .user
                    )
                    PromptView(
                        promptText: promptResponse,
                        type: .bot
                    )
                    Color.clear
                        .frame(height: 1)
                        .id("bottom")
                }
                .padding()
            }
            .onAppear {
                getPromptHistory()
            }
            .onChange(of: promptHistory) { _, _ in
                proxy.scrollTo("bottom", anchor: .bottom)
            }
            HomeTextField { text in
                getPromptHistory()
                promptText = text
                PromptNetworkManager.shared.sendChat(
                    id: keychain.load(type: .userID),
                    message: text
                )
                .asObservable()
                .bind { response in
                    promptResponse = response
                }.disposed(by: disposeBag)
            }
        }
        .padding()
        .navigationTitle("홈")
        .navigationBarTitleDisplayMode(.inline)
    }

    func getPromptHistory() {
        PromptNetworkManager.shared.history(
            id: keychain.load(type: .userID)
        )
        .asObservable()
        .bind { response in
            promptHistory = response
        }.disposed(by: disposeBag)
    }
}

#Preview {
    NavigationStack {
        RootTabView()
    }
}
