import SwiftUI

struct MainMenuView: View {
    @State private var searchText = ""
    @State private var selectedCategory = "All"

    private let green = Color(red: 0.18, green: 0.35, blue: 0.29)
    private let yellow = Color(red: 0.96, green: 0.78, blue: 0.16)
    private let categories = ["All", "Starters", "Mains", "Desserts", "Drinks"]

    private var filteredItems: [MenuItem] {
        MenuItem.samples.filter { item in
            let matchesCategory = selectedCategory == "All" || item.category == selectedCategory
            let matchesSearch = searchText.isEmpty
                || item.name.localizedCaseInsensitiveContains(searchText)
                || item.description.localizedCaseInsensitiveContains(searchText)
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    heroSection
                    categorySection
                    menuListSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 30)
            }
            .background(Color(.systemBackground))
            .toolbar(.hidden, for: .navigationBar)
        }
        .tint(green)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("LITTLE LEMON")
                    .font(.system(size: 21, weight: .black, design: .rounded))
                    .tracking(1.1)
                    .foregroundStyle(green)
                Text("CHICAGO")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(3)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            NavigationLink {
                ProfileView()
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(green)
                    .accessibilityLabel("Open profile")
            }
        }
        .padding(.vertical, 6)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Little Lemon")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(yellow)
                    Text("Chicago")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)
                    Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.92))
                        .lineSpacing(3)
                }
                Spacer(minLength: 0)
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 63))
                    .foregroundStyle(yellow)
                    .padding(.top, 8)
            }
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Search menu", text: $searchText)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            .padding(13)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 11))
        }
        .padding(18)
        .background(green)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ORDER FOR DELIVERY")
                .font(.system(size: 15, weight: .heavy, design: .rounded))
                .tracking(0.6)
                .foregroundStyle(green)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 9) {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .foregroundStyle(selectedCategory == category ? .white : green)
                                .background(selectedCategory == category ? green : yellow.opacity(0.24))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var menuListSection: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                Text("MENU")
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .tracking(0.8)
                    .foregroundStyle(green)
                Spacer()
                Text("\(filteredItems.count) items")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if filteredItems.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 28))
                        .foregroundStyle(.secondary)
                    Text("No dishes found")
                        .font(.headline)
                    Text("Try another search or choose a different category.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 28)
            } else {
                ForEach(filteredItems) { item in
                    MenuItemRow(item: item, green: green, yellow: yellow)
                    if item.id != filteredItems.last?.id {
                        Divider()
                    }
                }
            }
        }
    }
}

private struct MenuItemRow: View {
    let item: MenuItem
    let green: Color
    let yellow: Color

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                Text(item.price)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(green)
                    .padding(.top, 2)
            }
            Spacer(minLength: 4)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(yellow.opacity(0.23))
                Image(systemName: item.symbol)
                    .font(.system(size: 31))
                    .foregroundStyle(green)
            }
            .frame(width: 88, height: 84)
        }
        .padding(.vertical, 5)
    }
}
