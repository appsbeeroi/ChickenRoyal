import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabState = .catalog
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                switch selectedTab {
                case .catalog:
                    NavigationStack {
                        CatalogView()
                    }
                case .transport:
                    NavigationStack {
                        TransAccountingView()
                    }
                case .history:
                    NavigationStack {
                        ShippingHistoryView()
                    }
                case .settings:
                    NavigationStack {
                        SettingsView()
                    }
                }
            }
            
            CustomBar(selectedTab: $selectedTab)
                .padding(.bottom, 10)
                .background(Color.white)
        }
    }
}

#Preview {
    MainTabView()
        .withAutoPreviewEnvironment()
}

enum TabState: String, CaseIterable {
    case catalog = "tab1"
    case transport = "tab2"
    case history = "tab3"
    case settings = "tab4"
}

struct CustomBar: View {
    @Binding var selectedTab: TabState
    
    var body: some View {
        HStack {
            ForEach(TabState.allCases, id: \.self) { item in
                Spacer()
                Button {
                    selectedTab = item
                } label: {
                    Image(item.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(selectedTab == item ? Color(hex: "FFAE00") : .black.opacity(0.5))
                        .frame(height: 30)
                        .padding(10)
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
        
    }
}
