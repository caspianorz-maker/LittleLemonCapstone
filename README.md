# Little Lemon — iOS App Capstone

A small SwiftUI implementation of the Little Lemon food-ordering app brief.

## What's included

- Three-step first-launch onboarding (welcome, personal details, contact details).
- Main screen with Header, Hero, search, category selector, and food menu list.
- Profile screen populated from onboarding details.
- Profile editing with local persistence using `UserDefaults`.
- Log Out clears the saved profile and returns the app to onboarding.
- `NavigationStack` navigation to the profile screen, with the standard back button.
- Main-screen wireframe in `Design/MainScreenWireframe.svg` and JPG preview in `Design/MainScreenWireframe.jpg`.

## Open in Xcode

1. Open `LittleLemonCapstone.xcodeproj` in Xcode.
2. Select the `LittleLemonCapstone` scheme.
3. Choose an iPhone simulator (for example, iPhone 16 or a simulator available in your Xcode version).
4. Press **Run** (▶).
5. On first launch, complete all three onboarding pages. Use a name and an email containing `@` and a dot.
6. Open the profile icon, edit a field, tap **Save changes**, stop and relaunch the app, and confirm that the edit remains.
7. Tap **Log Out** and confirm that the app returns to onboarding and the previous details are no longer present.

## Add the wireframe to Figma and export JPG

1. In Figma, create or open a design file.
2. Drag `Design/MainScreenWireframe.svg` onto the canvas (or use File → Place image).
3. Select the imported wireframe.
4. In the right sidebar, open **Design → Export**, choose **JPG**, and export it.
5. Add the exported JPG to this repository and commit it. The included JPG is a preview; use the Figma-exported copy for the course submission if the reviewer specifically requires a Figma export.

## Push to GitHub

Create an empty repository on GitHub, then run these commands in Terminal from this folder (replace the URL with your repository URL):

```bash
git init
git add .
git commit -m "Add Little Lemon iOS capstone app"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```

## Before submitting

- [ ] Project opens and runs in Xcode.
- [ ] Onboarding has three pages and collects personal information.
- [ ] Main screen has Header, Hero, Menu Breakdown, and Food Menu List.
- [ ] Hero includes the Little Lemon description and search field.
- [ ] Category buttons filter the menu list.
- [ ] Profile shows onboarding data.
- [ ] Profile edits remain after relaunch.
- [ ] Log Out clears the saved profile and returns to onboarding.
- [ ] Figma-exported JPG wireframe is committed to GitHub.
- [ ] GitHub repository URL is pasted into Coursera **My Submission**.

## Notes

This is a starter implementation using SwiftUI and local sample menu data. It does not connect to a backend, payment provider, or live restaurant inventory. Run it in Xcode and verify it on your own simulator/device before submitting.
