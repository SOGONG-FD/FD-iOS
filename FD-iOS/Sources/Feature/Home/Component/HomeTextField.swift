import SwiftUI

struct HomeTextField: View {
    @State var text: String = ""
    public var sendButtonDidTap: (String) -> Void

    init(
        sendButtonDidTap: @escaping (String) -> Void
    ) {
        self.sendButtonDidTap = sendButtonDidTap
    }

    var body: some View {
        Spacer()
        ZStack(alignment: .trailing) {
            TextField("증상에 대해 입력해주세요", text: $text)
                .padding(.trailing, 40)
                .padding()
            Button {
                sendButtonDidTap(text)
                text = ""
            } label: {
                Image.arrowUPIcon
                    .tint(.white)
            }
            .frame(width: 30, height: 30)
            .background(Color.black)
            .clipShape(Circle())
            .padding(.trailing)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 1)
        }
        .padding()
    }
}
