import SwiftUI

@main
struct LittleLemonApp: App {
    @StateObject private var appStore = AppStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appStore)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        Group {
            if appStore.didCompleteOnboarding, appStore.profile != nil {
                MainMenuView()
            } else {
                OnboardingView()
            }
        }
        .animation(.easeInOut, value: appStore.didCompleteOnboarding)
    }
}
