import SwiftUI
import CoreLocation

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var name: String = ""
    @State private var locationManager = CLLocationManager()

    let middleLatitude = 34.81754168324334

    var body: some View {
        VStack(spacing: 20) {
        
            if let savedName = UserDefaults.standard.string(forKey: "playerName") {
                Text("Hello, \(savedName)!")
                    .font(.title2)
                    .foregroundColor(.gray)

                earthImages

                Button("Continue") {
                    appState.playerName = savedName
                    handleLocationAndProceed()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                TextField("Insert Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 50)

                earthImages

                Button("Start") {
                    appState.playerName = name
                    UserDefaults.standard.set(name, forKey: "playerName")
                    handleLocationAndProceed()
                }
                .disabled(name.isEmpty)
                .padding()
                .background(name.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    var earthImages: some View {
        HStack(spacing: 40) {
            VStack {
                Image(colorScheme == .dark ? "earth_night_left" : "earth_day_left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 230)
                Text("West Side")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            VStack {
                Image(colorScheme == .dark ? "earth_night_right" : "earth_day_right")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 230)
                Text("East Side")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }

    @Environment(\.colorScheme) var colorScheme

    func handleLocationAndProceed() {
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            appState.playerSide = latitude > middleLatitude ? "East Side" : "West Side"
        } else {
            appState.playerSide = "West Side"
        }

        appState.currentScreen = .game
    }
}
