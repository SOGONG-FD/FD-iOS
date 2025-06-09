import SwiftUI

import RxSwift
import RxCocoa

enum PromptType {
    case user
    case bot
}

struct PromptView: View {
    let promptText: String
    @State var promptType: PromptType

    init(promptText: String, type: PromptType) {
        self.promptText = promptText
        self.promptType = type
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
                Text(promptText.isEmpty ? "질문을 입력해주세요": promptText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 2)
                    .padding(.leading, 10)
            } else {
                Text(promptText.isEmpty ? "잠시만 기다려주세요" : promptText)
                    .padding(.top, 2)
                    .padding(.leading, 10)
                Button("공유하기") {
                    PostNetworkManager.shared.createPost(req: .init(id: "test", title: "동빈아", content: "맞을래"))
                        .asObservable()
                        .subscribe()
                        .disposed(by: DisposeBag())
                }
            }
        }
    }
}
