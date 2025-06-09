import SwiftUI

import RxMoya

import RxSwift
import RxCocoa

struct BoardView: View {
    private let disposeBag = DisposeBag()
    @State var title: String = "안녕하세용"
    @State var date: String = "2025.03.22"
    @State var content: String = "렁;니ㅓㅇㄹㄴ미;ㅏㅓ\n렁ㄴ미ㅏ;"

    var body: some View {
        VStack {
            SearchBar()
            ScrollView {
                ForEach(0..<10) { _ in
                    BoardCell(
                        title: $title,
                        date: $date,
                        content: $content
                    )
                        .padding()
                }
            }
        }
        .navigationTitle("게시판")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            PostNetworkManager.shared.getPost()
                .asObservable()
                .bind {_ in 
                    
                }.disposed(by: disposeBag)
            
        }
    }
}

#Preview {
    NavigationStack {
        BoardView()
    }
}
