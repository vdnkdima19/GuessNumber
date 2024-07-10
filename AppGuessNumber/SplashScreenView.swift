import SwiftUI

struct SplashScreenView: View {
    @Binding var isActive: Bool

    let titleText: String = "Вгадай число"
    let teamInfoText: String = "Дмитрій Вдовенко"
    var body: some View {
        // MARK: Background
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // MARK: Title
                setText(someText: titleText)
                .multilineTextAlignment(.center)
                VStack {
                    Spacer()
                    // MARK: Load Animation
                    setProgressView()
                    
                        .onAppear {
                            onAppearFunc()
                        }
                        .padding()
                    Spacer()
                }
                
                VStack {
                    // MARK: Author Info
                    setText(someText: teamInfoText)
                }
                
            }
        }
    }
    private func onAppearFunc() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            withAnimation {
                isActive = true
            }
        }
    }
    @ViewBuilder
    private func setText(someText: String) -> some View {
        Text(someText)
            .foregroundColor(.white)
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
    @ViewBuilder
    private func setProgressView() -> some View {
        ProgressView()
            .controlSize(.large)
            .tint(.white)
            .foregroundColor(.white)
            .scaleEffect(1.3)
    }
}
#Preview {
    RootView()
}
