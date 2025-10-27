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
                    case .statistics:
                        StatisticsView()
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
    case statistics = "tab4"
    case settings = "tab5"
    
    var selectIcon: String {
        switch self {
            case .catalog:
                "tab1Select"
            case .transport:
                "tab2Select"
            case .history:
                "tab3Select"
            case .statistics:
                "tab4Select"
            case .settings:
                "tab5Select"
        }
    }
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
                    Image(selectedTab == item ? item.selectIcon : item.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(10)
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
        
    }
}
