import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    private let characterLimit = 20
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .overlay {
                HStack {
                    
                    ZStack(alignment: .leading) {
                        if text.isEmpty {
                            Text(placeholder)
                                .Titan(20, color: .black.opacity(0.5))
                                .padding(.leading, 16)
                        }
                        TextField("", text: $text)
                            .Titan(20, color: .black)
                            .padding(.leading, 16)
                            .frame(height: 60)
                            .keyboardType(keyboardType)
                            .onChange(of: text) { newValue in
                                if newValue.count > characterLimit {
                                    text = String(newValue.prefix(characterLimit))
                                }
                            }
                    }
                    if !text.isEmpty {
                        Button(action: {
                            text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 16)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        
        
    }
}
