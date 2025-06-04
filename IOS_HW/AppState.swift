
import Foundation
import  Combine


class AppState: ObservableObject{
    @Published var PlayerName: String = ""
    @Published var  PlayerSide: String = ""
    @Published var currentScreen: Screen = .welcome
    @Published var PlayScore = 0
    @Published var pcScore = 0
    
    enum Screen{
        case welcome,game,summary
    }
    
    func resetGame(){
        PlayScore = 0
        pcScore = 0
        currentScreen =  .game
    }
    
    func endGame(){
        currentScreen = .summary
    }
    


}
