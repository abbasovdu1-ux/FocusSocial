import SwiftUI

public struct HomeView: View {
    // В будущем здесь будет список платформ, пока для MVP берем YouTube
    private let platform = Platform.youtube
    
    // Состояние перехода к выбранной платформе
    @State private var isPlatformActive = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Выберите платформу")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                // Карточка YouTube
                Button(action: {
                    isPlatformActive = true
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "play.rectangle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(platform.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Только поиск и подписки. Без Shorts.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Скрытый NavigationLink для перехода
                NavigationLink(
          destination: PlatformView(platform: platform),
            isActive: $isPlatformActive
)
) {
                    EmptyView()
                }
            }
            .navigationTitle("FocusSocial")
        }
    }
}