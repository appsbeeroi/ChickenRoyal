
import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.selectedView {
            case .load:
                LoadingView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            viewModel.selectedView = .main
                        }
                    }
            case .main:
                MainTabView()
                    .wrappedInNavigation()
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    RootView()
}
