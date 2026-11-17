import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appStore: AppStore
    @State private var page = 0
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var showValidation = false

    private let green = Color(red: 0.18, green: 0.35, blue: 0.29)
    private let yellow = Color(red: 0.96, green: 0.78, blue: 0.16)

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("LITTLE")
                    .font(.system(size: 17, weight: .black, design: .rounded))
                    .tracking(1.5)
                Text("LEMON")
                    .font(.system(size: 17, weight: .black, design: .rounded))
                    .tracking(1.5)
                    .foregroundStyle(green)
                Spacer()
                Text("\(page + 1) / 3")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 22)

            HStack(spacing: 7) {
                ForEach(0..<3, id: \.self) { index in
                    Capsule()
                        .fill(index <= page ? yellow : Color.gray.opacity(0.2))
                        .frame(height: 5)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 18)

            Spacer(minLength: 24)

            Group {
                switch page {
                case 0:
                    welcomePage
                case 1:
                    personalDetailsPage
                default:
                    contactDetailsPage
                }
            }
            .padding(.horizontal, 24)

            Spacer(minLength: 24)

            Button(action: continueTapped) {
                HStack {
                    Spacer()
                    Text(page == 2 ? "Create account" : "Next")
                        .font(.headline)
                    Spacer()
                    Image(systemName: page == 2 ? "checkmark" : "arrow.right")
                        .font(.headline)
                }
                .foregroundStyle(.white)
                .padding(.vertical, 17)
                .padding(.horizontal, 18)
                .background(green)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
        .background(Color(.systemBackground))
        .alert("A little more information", isPresented: $showValidation) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter your first name and a valid email address to continue.")
        }
    }

    private var welcomePage: some View {
        VStack(spacing: 22) {
            ZStack {
                Circle()
                    .fill(yellow.opacity(0.25))
                    .frame(width: 176, height: 176)
                Image(systemName: "leaf.fill")
                    .font(.system(size: 82))
                    .foregroundStyle(green)
                    .rotationEffect(.degrees(-25))
            }
            Text("Welcome to\nLittle Lemon")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(green)
            Text("Fresh Mediterranean flavors, made with care. Create your profile to get started with your next favorite meal.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
    }

    private var personalDetailsPage: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Tell us about you")
                .font(.system(size: 29, weight: .bold, design: .rounded))
                .foregroundStyle(green)
            Text("Add your name and email to set up your Little Lemon profile.")
                .foregroundStyle(.secondary)
            inputField("First name", text: $firstName, symbol: "person")
                .textContentType(.givenName)
                .textInputAutocapitalization(.words)
            inputField("Last name", text: $lastName, symbol: "person")
                .textContentType(.familyName)
                .textInputAutocapitalization(.words)
            inputField("Email address", text: $email, symbol: "envelope")
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Spacer(minLength: 0)
        }
    }

    private var contactDetailsPage: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Stay in touch")
                .font(.system(size: 29, weight: .bold, design: .rounded))
                .foregroundStyle(green)
            Text("Add a phone number so your profile is ready for your next order. You can leave this field blank.")
                .foregroundStyle(.secondary)
            inputField("Phone number (optional)", text: $phone, symbol: "phone")
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(green)
                Text("Your details are saved on this device and can be edited later in Profile.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(14)
            .background(green.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer(minLength: 0)
        }
    }

    private func inputField(_ placeholder: String, text: Binding<String>, symbol: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .foregroundStyle(green)
                .frame(width: 20)
            TextField(placeholder, text: text)
                .padding(.vertical, 14)
        }
        .padding(.horizontal, 14)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func continueTapped() {
        if page == 0 {
            page = 1
        } else if page == 1 {
            guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
                  email.contains("@"), email.contains(".") else {
                showValidation = true
                return
            }
            page = 2
        } else {
            let newProfile = UserProfile(
                firstName: firstName.trimmingCharacters(in: .whitespaces),
                lastName: lastName.trimmingCharacters(in: .whitespaces),
                email: email.trimmingCharacters(in: .whitespaces),
                phone: phone.trimmingCharacters(in: .whitespaces)
            )
            appStore.finishOnboarding(with: newProfile)
        }
    }
}
