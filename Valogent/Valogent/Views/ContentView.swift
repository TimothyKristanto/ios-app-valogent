//
//  ContentView.swift
//  Valogent
//
//  Created by Timothy Kristanto on 19/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            TabView{
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
    //        .tabViewStyle(PageTabViewStyle())
            .accentColor(.black)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        ContentView()
            .environmentObject(modelData)
    }
}
