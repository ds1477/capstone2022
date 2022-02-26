//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI
import FirebaseCore

class AppState: ObservableObject {
    @Published var hasOnboarded: Bool
    
    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
    }
}

class QRState: ObservableObject {
    @Published var hasOnboarded2: Bool
    
    init(hasOnboarded2: Bool) {
        self.hasOnboarded2 = hasOnboarded2
    }
}

@main
struct digidApp: App {
    
    @ObservedObject var appState = AppState(hasOnboarded: false)
    @ObservedObject var qrState = QRState(hasOnboarded2: false)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if appState.hasOnboarded {
                LandingView()
                    .environmentObject(appState)
            }
            else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
