# WebViewApp

A minimal SwiftUI iOS app that opens https://vnull.cfd/ in a WKWebView.
Targets iOS 16.0 and up. Built to be compiled via Codemagic (no local Mac/Xcode required).

## What's in here

- `WebViewApp.xcodeproj` — the Xcode project (target: iOS 16.0+)
- `WebViewApp/WebViewAppApp.swift` — app entry point
- `WebViewApp/ContentView.swift` — main screen, shows a loading spinner over the WebView
- `WebViewApp/WebView.swift` — WKWebView wrapper (UIViewRepresentable)
- `WebViewApp/Assets.xcassets` — app icon slot + accent color (currently empty placeholders — add your own icon before shipping)
- `codemagic.yaml` — Codemagic CI/CD build configuration

## Setup steps (GitHub + Codemagic)

1. **Push this folder to a new GitHub repository.**
   ```
   cd WebViewApp
   git init
   git add .
   git commit -m "Initial commit: WebView iOS app"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Sign up at [codemagic.io](https://codemagic.io)** and connect your GitHub account.

3. **Add the app** — Codemagic will detect `codemagic.yaml` automatically and use the `ios-webview-app` workflow.

4. **Set up code signing** (required to produce an installable .ipa):
   - Go to your app in Codemagic → **Team settings** → **Code signing identities**, or
   - Use **App Store Connect integration** (recommended): generate an API key in App Store Connect → Users and Access → Keys, then add it under Codemagic → Team settings → Integrations → App Store Connect. Codemagic can then auto-generate certificates and provisioning profiles for you — no manual cert wrangling needed.
   - You'll need an active **Apple Developer Program membership** ($99/year) to sign and distribute, even via TestFlight.

5. **Update the bundle identifier** in `codemagic.yaml` (`BUNDLE_ID`) and in the Xcode project build settings to something unique you own, e.g. `com.yourname.webviewapp`. It must match what you register in App Store Connect.

6. **Run the build** — push a commit or trigger manually from the Codemagic dashboard. On success you'll get a downloadable `.ipa` artifact, and (if configured) it can auto-publish to TestFlight.

## Before submitting to the App Store

- Replace the placeholder `AppIcon.appiconset` with a real 1024x1024 icon (Codemagic build will still succeed without one, but App Store submission will reject a missing icon).
- Apple review guidelines discourage apps that are *just* a bare website wrapper with no native functionality — consider adding at least a few native touches (share sheet, native tab bar, offline error screen, pull-to-refresh) to reduce rejection risk. Ask me if you'd like these added.
- Double check `https://vnull.cfd/` has a valid SSL certificate; if not, the WebView will fail to load under default App Transport Security settings.
