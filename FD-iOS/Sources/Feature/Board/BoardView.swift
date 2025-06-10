import SwiftUI

import RxMoya

import RxSwift
import RxCocoa

struct BoardView: View {
    private let disposeBag = DisposeBag()
    @State private var searchText: String = ""
    @State private var postResponse: [PostResponseElement] = []

    var body: some View {
        VStack {
            ScrollView {
                ForEach(searchResults, id: \.self) { data in
                    BoardCell(
                        title: data.title,
                        date: data.createdAt,
                        content: data.content,
                        createAt: data.createdAt
                    )
                    .padding()
                }
            }
        }
        .padding(.top, 10)
        .navigationTitle("게시판")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "검색어를 입력해주세요")
        .onAppear {
            PostNetworkManager.shared.getPost()
                .asObservable()
                .bind { data in
                    postResponse = data
                }.disposed(by: disposeBag)
            
        }
    }

    var searchResults: [PostResponseElement] {
            if searchText.isEmpty {
                return postResponse
            } else {
                return postResponse.filter {
                    $0.title.contains(searchText) || $0.content.contains(searchText)
                }
            }
        }
}

#Preview {
    NavigationStack {
        BoardView()
    }
}
