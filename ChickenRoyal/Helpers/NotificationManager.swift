import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization(hour: Int = 9, minute: Int = 0, completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            completion(granted)
        }
    }
    
    func scheduleDailyTransportReminder(hour: Int = 9, minute: Int = 0) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["dailyTransportReminder"])
        
        let content = UNMutableNotificationContent()
        content.title = "🚚 Transport Reminder"
        content.body = "Check your scheduled bird transports for today 🐦"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyTransportReminder", content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func cancelDailyTransportReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyTransportReminder"])
    }
}

