import SwiftUI

struct ContentView: View {
    private let siteURL = URL(string: "https://vnull.cfd/")!
    @State private var isLoading = true

    var body: some View {
        ZStack {
            WebView(url: siteURL, isLoading: $isLoading)
                .ignoresSafeArea(edges: .bottom)

            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
    }
}

#Preview {
    ContentView()
}
