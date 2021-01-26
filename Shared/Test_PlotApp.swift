//
//  Test_PlotApp.swift
//  Shared
//
//  Created by Jeff Terry on 1/25/21.
//

import SwiftUI

@main
struct Test_PlotApp: App {
    
    @StateObject var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(plotData)
                    .tabItem {
                        Text("Plot")
                    }
                TextView()
                    .environmentObject(plotData)
                    .tabItem {
                        Text("Text")
                    }
                            
                            
            }
            
        }
    }
}
