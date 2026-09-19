import SwiftUI

public struct PlatformView: View {
    public let platform: Platform
    
    @State private var blockedReason: String?
    private let filter: NavigationFilter
    
    public init(platform: Platform) {
        self.platform = platform
        self.filter = NavigationFilter(platform: platform)
    }
    
    public var body: some View {
        ZStack {
            // Открываем сразу страницу подписок или поиска, чтобы обойти главную
            WebView(
                initialURL: URL(string: "https://m.youtube.com/feed/subscriptions")!,
                filter: filter,
                blockedReason: $blockedReason
            )
            
            // Если страница заблокирована — показываем заглушку поверх
            if let reason = blockedReason {
                BlockedView(reason: reason) {
                    blockedReason = nil
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .navigationTitle(platform.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}