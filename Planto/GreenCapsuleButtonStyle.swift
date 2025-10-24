import SwiftUI

struct GreenCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white) // changed from .black to .white
            .background(
                Capsule()
                    .fill(Color("greeny"))
                    .opacity(configuration.isPressed ? 0.8 : 1.0)
            )
            .shadow(color: Color("greeny").opacity(configuration.isPressed ? 0.2 : 0.35),
                    radius: configuration.isPressed ? 4 : 8,
                    y: configuration.isPressed ? 2 : 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
