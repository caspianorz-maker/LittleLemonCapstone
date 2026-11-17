import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appStore: AppStore
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var showSavedMessage = false
    @State private var showLogoutConfirmation = false

    private let green = Color(red: 0.18, green: 0.35, blue: 0.29)

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(green)
                        Text("Personal information")
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
            }

            Section("Profile details") {
                TextField("First name", text: $firstName)
                    .textContentType(.givenName)
                TextField("Last name", text: $lastName)
                    .textContentType(.familyName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
            }

            Section {
                Button {
                    saveProfile()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save changes").fontWeight(.semibold)
                        Spacer()
                    }
                }
                .listRowBackground(green)
                .foregroundStyle(.white)
                .alert("Profile saved", isPresented: $showSavedMessage) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your changes will still be here when you reopen the app.")
                }
            }

            Section {
                Button(role: .destructive) {
                    showLogoutConfirmation = true
                } label: {
                    HStack {
                        Spacer()
                        Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                        Spacer()
                    }
                }
                .confirmationDialog("Log out of Little Lemon?", isPresented: $showLogoutConfirmation, titleVisibility: .visible) {
                    Button("Log Out and clear profile", role: .destructive) {
                        appStore.logOut()
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Your saved profile details will be removed from this device.")
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: loadProfile)
    }

    private func loadProfile() {
        guard let profile = appStore.profile else { return }
        firstName = profile.firstName
        lastName = profile.lastName
        email = profile.email
        phone = profile.phone
    }

    private func saveProfile() {
        let updatedProfile = UserProfile(
            firstName: firstName.trimmingCharacters(in: .whitespaces),
            lastName: lastName.trimmingCharacters(in: .whitespaces),
            email: email.trimmingCharacters(in: .whitespaces),
            phone: phone.trimmingCharacters(in: .whitespaces)
        )
        appStore.updateProfile(updatedProfile)
        showSavedMessage = true
    }
}
