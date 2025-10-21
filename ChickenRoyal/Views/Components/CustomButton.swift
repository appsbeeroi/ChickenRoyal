
import SwiftUI

struct CustomButton: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        }label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(hex: "FFAD15"))
                .frame(maxWidth: .infinity, minHeight: 65, maxHeight: 65)
                .overlay {
                    Text(text)
                        .Titan(20)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                }
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CustomButton(text: "Add bird"){}
}
