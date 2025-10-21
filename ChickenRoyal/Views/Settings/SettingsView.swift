import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsVM = SettingsViewModel()
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var notificationsEnabled = true
    @State private var isShowAlert: Bool = false
    var body: some View {
        Background {
            VStack(spacing: 16) {
                header
                
                VStack(spacing: 12) {

                    SettingRow {
                        HStack {
                            Text("Notification")
                                .Titan(20, color: .black)
                            Spacer()
                            Toggle("", isOn: $settingsVM.isNotificationEnabled)
                                .labelsHidden()
                                .tint(Color.init(hex: "F3B142"))
                        }
                    }
                    
                    Button {
                        if let url = URL(string: "https://sites.google.com/view/birdmove/home") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        SettingRow {
                            HStack {
                                Text("About the app")
                                    .Titan(20, color: .black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.init(hex: "F3B142"))
                            }
                        }
                    }
                    
                    
                    SettingRow {
                        HStack {
                            Text("History")
                                .Titan(20, color: .black)
                            Spacer()
                            Text("Clear")
                                .Titan(20, color: .red)
                        }
                    }.onTapGesture {
                        isShowAlert = true
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .alert(isPresented: $isShowAlert) {
            callAlert
        }
    }
}

#Preview {
    SettingsView()
        .wrappedInNavigation()
}

extension SettingsView {
    private var header: some View {
        Text("Settings")
            .Titan(35, color: .black)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding(.vertical, 24)
    }
    
    struct SettingRow<Content: View>: View {
        @ViewBuilder var content: Content
        
        var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 60)
                .overlay(
                    content
                        .padding(.horizontal, 16)
                )
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        }
    }
    
    private var callAlert: Alert {
        Alert(
            title: Text("Clear history"),
            message: Text("Are you sure you want to delete the entire history? \nThis action cannot be undone."),
            primaryButton: .destructive(Text("Delete")) {
            
                vm.clear()
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }
}


