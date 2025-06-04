//
//  ContentView.swift
//  IOS_HW
//
//  Created by Student25 on 05/06/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState : AppState
    
    var body: some View{
        switch appState.currentScreen{
        case .welcome:
            WelcomeView()
        case .game :
            Text("game screen")
        case .summary:
            Text("summer Screen")
            
        }
    }
    
    
    
}
