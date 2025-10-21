
import SwiftUI


extension View {
    func addDoneButton() -> some View {
        self.toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
                }
                .hTrailing()
            }
        }
    }
}

