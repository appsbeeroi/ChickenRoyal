import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var isNotificationEnabled: Bool {
        didSet {
            if isNotificationEnabled {
                NotificationManager.shared.requestAuthorization { granted in
                    DispatchQueue.main.async {
                        if !granted {
                         
                            self.isNotificationEnabled = false
                        } else {
                            UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                            NotificationManager.shared.scheduleDailyTransportReminder()
                        }
                    }
                }
            } else {
                UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                NotificationManager.shared.cancelDailyTransportReminder()
            }
        }
    }
    
    init() {
        self.isNotificationEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        if isNotificationEnabled {
            NotificationManager.shared.scheduleDailyTransportReminder()
        }
    }
}
