import Foundation

public struct Platform: Identifiable {
    public let id: String
    public let name: String
    public let baseURL: URL
    public let allowedPaths: [String]
    public let blockedPaths: [String]
    
    public init(
        id: String,
        name: String,
        baseURL: URL,
        allowedPaths: [String],
        blockedPaths: [String]
    ) {
        self.id = id
        self.name = name
        self.baseURL = baseURL
        self.allowedPaths = allowedPaths
        self.blockedPaths = blockedPaths
    }
}

// Конфигурация для первого этапа MVP (YouTube)
extension Platform {
    public static let youtube = Platform(
        id: "youtube",
        name: "YouTube",
        baseURL: URL(string: "https://m.youtube.com")!,
        allowedPaths: [
            "/watch",               // Просмотр конкретного видео
            "/results",             // Поисковая выдача
            "/feed/subscriptions",  // Подписки
            "/playlist"             // Списки воспроизведения
        ],
        blockedPaths: [
            "/shorts",              // Короткие ролики
            "/trending",            // Тренды
            "/explore"              // Рекомендации
        ]
    )
}