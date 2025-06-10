import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.currentScreen {
        case .welcome:
            WelcomeView()
        case .game:
            GameView()
        case .summary:
            SummaryView()
        }
    }
}
