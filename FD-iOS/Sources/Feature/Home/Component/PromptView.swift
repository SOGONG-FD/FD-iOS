import SwiftUI

import RxSwift
import RxCocoa

enum PromptType {
    case user
    case bot
}
struct PromptView: View {
    private let disposeBag = DisposeBag()
    private let keychain = KeychainImpl()
    private let promptText: String
    private let promptType: PromptType
    private let title: String
    private let content: String

    init(
        promptText: String,
        type: PromptType,
        title: String? = nil,
        content: String? = nil
    ) {
        self.promptText = promptText
        self.promptType = type
        self.title = title ?? "제목 없음"
        self.content = content ?? "내용 없음"
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 8) {
                Circle()
                    .fill(promptType == .bot ? Color.brown : Color.cyan)
                    .frame(width: 15, height: 15)
                Text(promptType == .bot ? "AI" : "YOU")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
                Spacer()
            }

            if promptType == .user {
                Text(promptText.isEmpty ? "질문을 입력해주세요" : promptText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 2)
                    .padding(.leading, 10)
            } else {
                Text(promptText.isEmpty ? "잠시만 기다려주세요" : promptText)
                    .padding(.top, 2)
                    .padding(.leading, 10)

                if !promptText.isEmpty {
                    Button("공유하기") {
                        let userID = keychain.load(type: .userID)
                        let request = CreatePostParams(
                            id: userID,
                            title: title,
                            content: content
                        )

                        PostNetworkManager.shared.createPost(req: request)
                            .asObservable()
                            .subscribe()
                            .disposed(by: disposeBag)
                    }
                    .frame(width: 80, height: 40)
                    .background(Color.fmNeon)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
        }
    }
}
