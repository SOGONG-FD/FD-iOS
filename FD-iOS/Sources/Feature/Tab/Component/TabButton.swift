import SwiftUI

struct TabButton: View {
    @Binding private var selected: TabType
    var type: TabType
    var image: Image
    var action: (() -> Void)?

    init(
        selected: Binding<TabType>,
        type: TabType,
        image: Image
    ) {
        self._selected = selected
        self.type = type
        self.image = image
    }

    var body: some View {
        Button {
            selected = type
            action?()
        } label: {
            VStack(alignment: .center) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                if selected == type {
                    Text(type.rawValue)
                        .font(.system(size: 11))
                }
            }
        }
        .foregroundStyle(selected == type ? Color.fmNeon : Color.black)
    }
}

#Preview {
    RootTabView()
}
