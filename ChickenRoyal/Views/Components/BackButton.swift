
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button{
            dismiss()
        }label: {
            Image("BackButton")
                .resizable()
                .scaledToFit()
                .frame(height: 42)
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    BackButton()
}
