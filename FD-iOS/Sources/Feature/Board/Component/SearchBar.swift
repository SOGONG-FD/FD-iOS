import SwiftUI

struct SearchBar: View {
    @State var text: String = ""

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("", text: $text)
                .padding(.trailing, 30)
                .padding()
                .tint(.fmNeon)
            Button {
                
            } label: {
                Image.searchIcon
                    .tint(.gray)
            }
            .frame(width: 30, height: 30)
            .padding(.trailing)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 1)
        }
        .padding()
        Spacer()
    }
}

#Preview {
    SearchBar()
}
