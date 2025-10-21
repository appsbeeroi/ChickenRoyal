import SwiftUI

struct LoadingView: View {
    @State private var textVisible = false

    var body: some View {
        ZStack {
            Image("bgLoading")
                .resizable()
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                
                    VStack {
                        Text("BirdMove")
                            .Titan(64)
                            .shadow(color: .black.opacity(0.5), radius: 0, x: 0, y: 5)

                        SemiCircleLoader()
                    }
                    .frame(height: geo.size.height / 2)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .onAppear {
            textVisible = true
        }
    }
}


struct SemiCircleLoader: View {
    @State private var rotate = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.5)
 
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white]),
                    center: .center
                ),
                style: StrokeStyle(lineWidth: 6, lineCap: .round)
            )
            .rotationEffect(.degrees(rotate ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: rotate)
            .frame(height: 50)
            .onAppear {
                rotate = true
            }
    }
}

#Preview {
    LoadingView()
}
