

import SwiftUI


struct Background<Content: View>: View {
    private let content: Content
    
    @inlinable
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }
    var body: some View {
        ZStack {
            Image("mainBg")
                .resizable()
                .ignoresSafeArea()
            
            content
        }

    }
}

#Preview {
    Background() {}
}



