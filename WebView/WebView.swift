import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public let initialURL: URL
    public let filter: NavigationFilter
    @Binding public var blockedReason: String?
    
    public init(
        initialURL: URL,
        filter: NavigationFilter,
        blockedReason: Binding<String?>
    ) {
        self.initialURL = initialURL
        self.filter = filter
        self._blockedReason = blockedReason
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        // Разрешаем встроенное воспроизведение видео (inline)
        configuration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: initialURL)
        webView.load(request)
        
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // MARK: - Coordinator
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // Перехват перехода по ссылке
        public func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }
            
            // Проверяем URL через NavigationFilter
            let decision = parent.filter.evaluate(url: url)
            
            switch decision {
            case .allow:
                decisionHandler(.allow)
            case .block(let reason):
                decisionHandler(.cancel)
                DispatchQueue.main.async {
                    self.parent.blockedReason = reason
                }
            }
        }
    }
}