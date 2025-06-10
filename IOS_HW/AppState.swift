import Foundation
import Combine

class AppState: ObservableObject {
    @Published var playerName: String = ""
    @Published var playerSide: String = ""
    @Published var currentScreen: Screen = .welcome
    @Published var playerScore: Int = 0
    @Published var pcScore: Int = 0

    enum Screen {
        case welcome, game, summary
    }

    func resetGame() {
        playerScore = 0
        pcScore = 0
        currentScreen = .game
    }

    func endGame() {
        currentScreen = .summary
    }
}
