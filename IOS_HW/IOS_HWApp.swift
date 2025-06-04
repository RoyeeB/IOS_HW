//
//  IOS_HWApp.swift
//  IOS_HW
//
//  Created by Student25 on 05/06/2025.
//

import SwiftUI

@main
struct IOS_HWApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
