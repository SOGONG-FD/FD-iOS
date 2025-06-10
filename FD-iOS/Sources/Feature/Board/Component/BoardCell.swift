import SwiftUI

struct BoardCell: View {
    let title: String
    let date: String
    let content: String
    let createAt: String

    init(
        title:String,
        date:String,
        content: String,
        createAt: String
    ) {
        self.title = title
        self.date = date
        self.content = content
        self.createAt = createAt
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
                    DetailBoardView(
                        title: title,
                        content: content,
                        createAt: createAt
                    )
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
