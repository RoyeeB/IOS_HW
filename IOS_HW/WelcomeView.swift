import SwiftUI
import CoreLocation


struct WelcomeView: View {
    @EnvironmentObject var appState : AppState
    @State private var name: String = ""
    @State private var locationManger = CLLocationManager()
    
    let middleLatitude = 34.81754168324334
    
    var body: some View {
        VStack (spacing: 30){
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
            
            TextField("Insert Name" , text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal , 50)
            
            Button ("Start"){
                handleStart()
            }
            .disabled(name.isEmpty)
            .padding()
            .background(name.isEmpty ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear(){
            locationManger.requestWhenInUseAuthorization()
        }
    }
    
    func handleStart(){
        appState.PlayerName = name
        
        if let location = locationManger.location{
            let latitude = location.coordinate.latitude
            appState.PlayerSide = latitude > middleLatitude ? "East Side" : "West Side"
        }
        else {
            appState.PlayerSide = "West Side"
        }
        
        appState.currentScreen = .game
        
    }
}

