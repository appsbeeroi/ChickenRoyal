
import SwiftUI

@main
struct ChickenRoyalApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    NotificationManager.shared.requestAuthorization { _ in
                        //
                    }
                }
        }
    }
}
