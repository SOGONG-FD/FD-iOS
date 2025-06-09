import SwiftUI

struct RootTabView: View {
    @State private var selected: TabType = .home
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    NavigationStack {
                        BoardView()
                    }
                    .tag(TabType.board)
                    NavigationStack {
                        HomeView()
                    }
                    .tag(TabType.home)
                    NavigationStack {
                        MyPageView()
                    }
                    .tag(TabType.myPage)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            .padding(.bottom, 60)

            VStack {
                Spacer()
                TabBar(selected: $selected)
            }
            .navigationBarBackButtonHidden()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    RootTabView()
}
