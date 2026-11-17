import Foundation
import SwiftUI

@MainActor
final class AppStore: ObservableObject {
    @Published private(set) var profile: UserProfile?
    @Published private(set) var didCompleteOnboarding: Bool

    private let profileKey = "littleLemon.profile"
    private let onboardingKey = "littleLemon.didCompleteOnboarding"

    init() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: profileKey),
           let savedProfile = try? JSONDecoder().decode(UserProfile.self, from: savedData) {
            profile = savedProfile
        } else {
            profile = nil
        }
        didCompleteOnboarding = defaults.bool(forKey: onboardingKey) && profile != nil
    }

    func finishOnboarding(with newProfile: UserProfile) {
        profile = newProfile
        didCompleteOnboarding = true
        persistProfile()
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }

    func updateProfile(_ updatedProfile: UserProfile) {
        profile = updatedProfile
        persistProfile()
    }

    func logOut() {
        profile = nil
        didCompleteOnboarding = false
        UserDefaults.standard.removeObject(forKey: profileKey)
        UserDefaults.standard.removeObject(forKey: onboardingKey)
    }

    private func persistProfile() {
        guard let profile,
              let data = try? JSONEncoder().encode(profile) else { return }
        UserDefaults.standard.set(data, forKey: profileKey)
    }
}
