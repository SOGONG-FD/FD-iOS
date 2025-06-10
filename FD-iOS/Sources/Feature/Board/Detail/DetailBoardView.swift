import SwiftUI

struct DetailBoardView: View {
    @State private var title: String
    @State private var content: String
    @State private var createAt: String

    init(
        title: String,
        content: String,
        createAt: String
    ) {
        self.title = title
        self.content = content
        self.createAt = createAt
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(title)
                    .font(.largeTitle)
                Spacer()
            }
            Text(createAt)
            Divider()
                .background(Color.fmNeon)
            ScrollView {
                Text(content)
            }
        }
        .padding()
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
    }
    
}

#Preview {
    DetailBoardView(title: "fjdsl", content: "Fdjsl", createAt: "fjsdlk")
}
