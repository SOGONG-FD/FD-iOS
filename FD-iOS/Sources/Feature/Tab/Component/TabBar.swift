import SwiftUI

struct TabBar: View {
    @Binding private var selected: TabType

    init(selected: Binding<TabType>) {
        self._selected = selected
    }
    var body: some View {
        HStack {
            Spacer()
            TabButton(selected: $selected, type: .board, image: .boardIcon)
            Spacer()
            TabButton(selected: $selected, type: .home, image: .homeIcon)
            Spacer()
            TabButton(selected: $selected, type: .myPage, image: .myPageIcon)
            Spacer()
        }
        .frame(height: 70)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
    }
}
