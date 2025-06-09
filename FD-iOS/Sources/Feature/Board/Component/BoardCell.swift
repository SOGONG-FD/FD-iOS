import SwiftUI

struct BoardCell: View {
    @Binding var title: String
    @Binding var date: String
    @Binding var content: String

    init(
        title: Binding<String>,
        date: Binding<String>,
        content: Binding<String>
    ) {
        self._title = title
        self._date = date
        self._content = content
    }

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Text(date)
            }
            .padding()
            HStack {
                Text(content)
                    .padding(.bottom, 40)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 30)
                Spacer()
                NavigationLink {
                    DetailBoardView()
                } label: {
                    Text("상세보기")
                        .foregroundStyle(.black)
                    Image.chevronRightIcon
                        .tint(.black)
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
        Rectangle()
            .foregroundStyle(.gray)
            .opacity(0.3)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
    }
}

#Preview {
    RootTabView()
}
