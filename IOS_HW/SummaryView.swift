import SwiftUI
import AVFoundation

struct SummaryView: View {
    @EnvironmentObject var appState: AppState
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Game Over")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)

                Text(resultMessage())
                    .font(.title)
                    .foregroundColor(.orange)
                    .padding()

                VStack(spacing: 10) {
                    Text("\(appState.playerName): \(appState.playerScore)")
                    Text("PC: \(appState.pcScore)")
                }
                .font(.title2)
                .foregroundColor(.primary)

                Button(action: {
                    appState.resetGame()
                }) {
                    Text("Play Again")
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            if appState.playerScore > appState.pcScore {
                playWinnerSound()
            }
        }
    }

    func resultMessage() -> String {
        if appState.playerScore > appState.pcScore {
            return "Winner: \(appState.playerName)"
        } else if appState.pcScore > appState.playerScore {
            return "Winner: PC"
        } else {
            return "It's a tie!"
        }
    }

    func playWinnerSound() {
        if let url = Bundle.main.url(forResource: "winnerSound", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Failed to play winner sound: \(error.localizedDescription)")
            }
        } else {
            print("Winner sound file not found")
        }
    }
}
