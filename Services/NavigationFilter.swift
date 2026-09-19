import Foundation

public struct NavigationFilter {
    public let platform: Platform
    
    public init(platform: Platform) {
        self.platform = platform
    }
    
    /// Решение о том, разрешать ли переход по URL
    public enum Decision {
        case allow
        case block(reason: String)
    }
    
    /// Проверяет URL и возвращает решение: allow или block
    public func evaluate(url: URL) -> Decision {
        // 1. Проверяем домен (чтобы не уйти на сторонние фишинговые сайты)
        guard let host = url.host?.lowercased(),
              host.contains("youtube.com") || host.contains("googlevideo.com") || host.contains("google.com") else {
            return .block(reason: "Переход на внешний ресурс заблокирован")
        }
        
        let path = url.path.lowercased()
        
        // 2. Блокируем пустой путь или корень (главная страница со лентой рекомендаций)
        if path.isEmpty || path == "/" {
            return .block(reason: "Главная лента рекомендаций заблокирована")
        }
        
        // 3. Проверяем явный список запретов (Shorts, Explore, Trending)
        for blocked in platform.blockedPaths {
            if path.hasPrefix(blocked.lowercased()) {
                return .block(reason: "Раздел '\(blocked)' заблокирован режимом фокусировки")
            }
        }
        
        // 4. Проверяем список разрешенных путей (Watch, Results/Поиск, Подписки)
        for allowed in platform.allowedPaths {
            if path.hasPrefix(allowed.lowercased()) {
                return .allow
            }
        }
        
        // 5. Разрешаем вспомогательные запросы авторизации Google/YouTube (login, accounts)
        if path.contains("signin") || path.contains("serviceLogin") || host.contains("accounts.google.com") {
            return .allow
        }
        
        // По умолчанию всё, что явно не разрешено — блокируем
        return .block(reason: "Данный раздел не входит в список разрешенных")
    }
}