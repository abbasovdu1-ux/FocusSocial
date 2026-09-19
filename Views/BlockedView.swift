import SwiftUI

public struct BlockedView: View {
    public let reason: String
    public let onDismiss: () -> Void
    
    public init(reason: String, onDismiss: @escaping () -> Void) {
        self.reason = reason
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "hand.raised.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.orange)
                
                Text("Фокус сохранён")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(reason)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Text("Вернуться назад")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
        }
    }
}