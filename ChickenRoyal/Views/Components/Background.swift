

import SwiftUI


struct Background<Content: View>: View {
    private let content: Content
    
    @inlinable
    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("bgLoading")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            .ignoresSafeArea()
            
            content
        }

    }
}

#Preview {
    Background() {}
}



