//
//  ValogentApp.swift
//  Valogent
//
//  Created by Timothy Kristanto on 19/05/22.
//

import SwiftUI

@main
struct ValogentApp: App {
    @StateObject var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
