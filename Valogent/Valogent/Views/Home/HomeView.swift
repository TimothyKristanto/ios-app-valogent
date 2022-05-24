//
//  HomeView.swift
//  Valogent
//
//  Created by Timothy Kristanto on 19/05/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let trendingNows = ["newAgentFade", "nerfedJettDash"]
    let filters = ["Sentinel", "Duelist", "Controller", "Initiator", "All"]
    
    @State private var searchText = ""
    @State private var filter = "All"
    @State private var showFavorite = false
    
    @EnvironmentObject var modelData: ModelData
//
//    @State private var secondAgentList = [Agent]()
    
    var searchResults: [Agent] {
        if(searchText.isEmpty){
            return modelData.agents
        }else{
            return modelData.agents.filter{
                $0.displayName.contains(searchText)
            }
        }
    }
    
    var filteredResults: [Agent]{
        if filter == "All"{
            return searchResults.filter{
                $0.isPlayableCharacter == true
            }
        }
        
        return searchResults.filter{
            $0.role?.displayName.rawValue ?? "Unknown" == filter
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    HStack{
                        Text("Trending Now")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .padding(.top, 20)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(trendingNows, id: \.self){ trendingNow in
                                ProfileCareerCardView(status: trendingNow)
                                    .frame(height: 230)
                                    .padding(.leading, 3)
                            }
                        }
                        
                    }
                    .padding(.trailing, 20)
                    .offset(y: -3)
                }
                .offset(x: 20)
                
                VStack{
                    HStack{
                        Text("Agents")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    
                    
                    HStack{
                        TextField("Search", text: $searchText)
                            .offset(x: 5)
                            .clipShape(Capsule())
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 17)
                                    .stroke(Color.secondary, lineWidth: 2)
                            )
                            .frame(height: 50)
                            .padding(.trailing, 10)
                        
                        Spacer()
                        
                        Menu {
                            Picker("Role", selection: $filter) {
                                ForEach(filters, id: \.self) { role in
                                    Text(role)
                                }
                            }
                            .pickerStyle(.inline)

                            Toggle(isOn: $showFavorite) {
                                Label("Favorites", systemImage: "star.fill")
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .scaledToFit()
                                .offset(x: 0)
                                .foregroundStyle(.blue)
                                .frame(height: 30, alignment: .leading)
                                .padding(.trailing, 20)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    
                }
                .offset(x: 20, y: -5)
                
                ScrollView{
                    ForEach($modelData.agents, id: \.uuid) { $agent in
                        NavigationLink{
                            // Todo: change to detail page
                            
                            ZStack{
                                LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                                
                                HStack{
                                    GeometryReader { geo in
                                        AsyncImage(url: URL(string: agent.fullPortraitV2 ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geo.size.width, height: geo.size.height * 0.77)
                                                .padding(.top, 40)
                                        } placeholder: {
                                            Color.red
                                        }
                                            
                                    }
                                }
                                
                                VStack{
                                    
                                    Spacer()
                                    
                                    HStack{
                                        AsyncImage(url: URL(string: agent.role?.displayIcon ?? "Unknown")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 45)
                                        } placeholder: {
                                            Color.red
                                        }
                                        .padding(.trailing, 5)
                                        
                                        Text(agent.displayName)
                                            .font(.largeTitle)
                                            .bold()
                                            .foregroundStyle(.white)
                                        
                                        Button {
                                            agent.isFavorite.toggle()
                                        } label: {
                                            Image(systemName: agent.isFavorite ? "star.fill" : "star")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.white)
                                                .frame(height: 25)
                                                .padding(.leading, 5)
                                        }
                                        
//                                        FavoriteButton(isSet: $modelData.agents[modelData.agents.firstIndex(where: { $0.uuid == agent.uuid })!].isFavorite)
                                        
                                    }
                                    
                                    Image(systemName: "chevron.up")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(height: 25)
                                    
                                    Text("Swipe up")
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.bottom, 50)
                                        
                                }
                            }
                            .ignoresSafeArea()
                        
                        } label: {
                            HStack{
                                AsyncImage(url: URL(string: agent.displayIcon)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                
                                Text(agent.displayName)
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.white)
                                    
                                Spacer()
                                AsyncImage(url: URL(string: agent.role?.displayIcon ?? "Unknown")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 25, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                
                                Text(agent.role?.displayName.rawValue ?? "Unknown")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 15)
                                
                                Image(systemName: agent.isFavorite ? "star.fill" : "star")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                                
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    
                            }
                            .padding(10)
                            .frame(height: 85, alignment: .center)
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            
                        }
                        
                    }
                }
                .onAppear(){
                    modelData.fetchData()
                }
                .padding(10)
                .shadow(radius: 5)
                
                Spacer()
                
            }
            .navigationBarTitle("Agent")
            .navigationBarHidden(true)
            
        }
        .accentColor(.white)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        HomeView()
            .environmentObject(modelData)
    }
}
