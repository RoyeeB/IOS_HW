import SwiftUI
import AVFoundation

struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    let power: Int
}

struct GameView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.scenePhase) private var scenePhase

    @State private var round: Int = 0
    @State private var playerCard = Card(imageName: "ace_of_spades", power: 14)
    @State private var pcCard = Card(imageName: "king_of_hearts", power: 13)
    @State private var showCards: Bool = false
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 5
    @State private var isPaused: Bool = false
    @State private var lastTimeRemaining: Int = 5
    @State private var audioPlayer: AVAudioPlayer?
    @State private var backgroundMusicPlayer: AVAudioPlayer?

    let cards: [Card] = [
        Card(imageName: "2_of_clubs", power: 2), Card(imageName: "2_of_diamonds", power: 2), Card(imageName: "2_of_hearts", power: 2), Card(imageName: "2_of_spades", power: 2),
        Card(imageName: "3_of_clubs", power: 3), Card(imageName: "3_of_diamonds", power: 3), Card(imageName: "3_of_hearts", power: 3), Card(imageName: "3_of_spades", power: 3),
        Card(imageName: "4_of_clubs", power: 4), Card(imageName: "4_of_diamonds", power: 4), Card(imageName: "4_of_hearts", power: 4), Card(imageName: "4_of_spades", power: 4),
        Card(imageName: "5_of_clubs", power: 5), Card(imageName: "5_of_diamonds", power: 5), Card(imageName: "5_of_hearts", power: 5), Card(imageName: "5_of_spades", power: 5),
        Card(imageName: "6_of_clubs", power: 6), Card(imageName: "6_of_diamonds", power: 6), Card(imageName: "6_of_hearts", power: 6), Card(imageName: "6_of_spades", power: 6),
        Card(imageName: "7_of_clubs", power: 7), Card(imageName: "7_of_diamonds", power: 7), Card(imageName: "7_of_hearts", power: 7), Card(imageName: "7_of_spades", power: 7),
        Card(imageName: "8_of_clubs", power: 8), Card(imageName: "8_of_diamonds", power: 8), Card(imageName: "8_of_hearts", power: 8), Card(imageName: "8_of_spades", power: 8),
        Card(imageName: "9_of_clubs", power: 9), Card(imageName: "9_of_diamonds", power: 9), Card(imageName: "9_of_hearts", power: 9), Card(imageName: "9_of_spades", power: 9),
        Card(imageName: "10_of_clubs", power: 10), Card(imageName: "10_of_diamonds", power: 10), Card(imageName: "10_of_hearts", power: 10), Card(imageName: "10_of_spades", power: 10),
        Card(imageName: "jack_of_clubs", power: 11), Card(imageName: "jack_of_diamonds", power: 11), Card(imageName: "jack_of_hearts", power: 11), Card(imageName: "jack_of_spades", power: 11),
        Card(imageName: "queen_of_clubs", power: 12), Card(imageName: "queen_of_diamonds", power: 12), Card(imageName: "queen_of_hearts", power: 12), Card(imageName: "queen_of_spades", power: 12),
        Card(imageName: "king_of_clubs", power: 13), Card(imageName: "king_of_diamonds", power: 13), Card(imageName: "king_of_hearts", power: 13), Card(imageName: "king_of_spades", power: 13),
        Card(imageName: "ace_of_clubs", power: 14), Card(imageName: "ace_of_diamonds", power: 14), Card(imageName: "ace_of_hearts", power: 14), Card(imageName: "ace_of_spades", power: 14)
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 30) {
                    Text("Round \(round) of 10")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)

                    HStack(spacing: 40) {
                        if appState.playerSide == "East Side" {
                            Spacer()
                            playerColumn(name: appState.playerName, image: showCards ? playerCard.imageName : "back", score: appState.playerScore, isWinner: showCards && playerCard.power > pcCard.power)
                            playerColumn(name: "PC", image: showCards ? pcCard.imageName : "back", score: appState.pcScore, isWinner: showCards && pcCard.power > playerCard.power)
                            Spacer()
                        } else {
                            Spacer()
                            playerColumn(name: "PC", image: showCards ? pcCard.imageName : "back", score: appState.pcScore, isWinner: showCards && pcCard.power > playerCard.power)
                            playerColumn(name: appState.playerName, image: showCards ? playerCard.imageName : "back", score: appState.playerScore, isWinner: showCards && playerCard.power > pcCard.power)
                            Spacer()
                        }
                    }

                    Text("Next round in: \(timeRemaining)s")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                .frame(width: geometry.size.width)
            }
        }
        .onAppear {
            if let savedName = UserDefaults.standard.string(forKey: "playerName") {
                appState.playerName = savedName
            }
            startRound()
            playBackgroundMusic()
        }
        .onDisappear {
            timer?.invalidate()
            stopBackgroundMusic()
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .inactive, .background:
                timer?.invalidate()
                lastTimeRemaining = timeRemaining
                isPaused = true
                stopBackgroundMusic()
            case .active:
                if isPaused {
                    resumeTimer(from: lastTimeRemaining)
                    isPaused = false
                    playBackgroundMusic()
                }
            default:
                break
            }
        }
    }

    func playerColumn(name: String, image: String, score: Int, isWinner: Bool) -> some View {
        VStack(spacing: 10) {
            Text(name)
                .font(.title3)
                .bold()
                .foregroundColor(.primary)

            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 180)
                .background(Color(white: 0.9))
                .cornerRadius(8)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isWinner ? Color.green : Color.primary, lineWidth: 3)
                )

            Text("Score: \(score)")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }

    func startRound() {
        if round >= 10 {
            stopBackgroundMusic()
            appState.endGame()
            return
        }

        round += 1
        showCards = false

        if let player = cards.randomElement(), let pc = cards.randomElement() {
            playerCard = player
            pcCard = pc
            print("\n--- Round \(round) ---")
            print("Player card: \(player.imageName) (Power: \(player.power))")
            print("PC card: \(pc.imageName) (Power: \(pc.power))")
        }

        resumeTimer(from: 5)
    }

    func resumeTimer(from seconds: Int) {
        timeRemaining = seconds
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            timeRemaining -= 1

            if timeRemaining == 3 {
                withAnimation {
                    showCards = true
                }
                playCardFlipSound()
            }

            if timeRemaining == 0 {
                t.invalidate()
                calculateScore()
                startRound()
            }
        }
    }

    func playCardFlipSound() {
        if let url = Bundle.main.url(forResource: "cardFlip", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Failed to play sound: \(error.localizedDescription)")
            }
        }
    }

    func playBackgroundMusic() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session: \(error.localizedDescription)")
        }

        if let url = Bundle.main.url(forResource: "backgroundSound", withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.volume = 0.5
                backgroundMusicPlayer?.play()
            } catch {
                print("Failed to play background music: \(error.localizedDescription)")
            }
        } else {
            print("Background music file not found")
        }
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        backgroundMusicPlayer = nil
    }

    func calculateScore() {
        if playerCard.power > pcCard.power {
            appState.playerScore += 1
        } else if pcCard.power > playerCard.power {
            appState.pcScore += 1
        }
    }
}
