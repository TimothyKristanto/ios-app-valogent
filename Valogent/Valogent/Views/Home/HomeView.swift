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
    @State private var favoritedAgents = [String]()
    @State private var showSheet: Bool = false
    
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
        var agentList = [Agent]()
        
        if showFavorite {
            agentList = searchResults.filter{
                favoritedAgents.contains($0.displayName)
            }
        }else{
            agentList = searchResults
        }
        
        if filter == "All"{
            agentList = agentList.filter{
                $0.isPlayableCharacter == true
            }
        }else{
            agentList = agentList.filter{
                $0.role?.displayName.rawValue ?? "Unknown" == filter
            }
        }
        
        return agentList
    }
    
    func removeFavoriteAgent(agent: Agent){
        favoritedAgents = favoritedAgents.filter{
            $0 != agent.displayName
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
                                    .frame(height: 180)
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
                                .frame(height: 28, alignment: .leading)
                                .padding(.trailing, 20)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    
                }
                .offset(x: 20, y: -5)
                
                ScrollView{
                    ForEach(filteredResults, id: \.uuid) { agent in
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
                                                .frame(height: 38)
                                        } placeholder: {
                                            Color.red
                                        }

                                        Text(agent.displayName)
                                            .font(.largeTitle)
                                            .bold()
                                            .foregroundStyle(.white)

                                        Button {
                                            favoritedAgents.contains(agent.displayName) ? removeFavoriteAgent(agent: agent) : favoritedAgents.append(agent.displayName)
                                        } label: {
                                            Image(systemName: favoritedAgents.contains(agent.displayName) ? "star.fill" : "star")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.white)
                                                .frame(height: 25)
                                        }
                                        .padding(.leading, 5)

                                    }
                                    
                                    Button{
                                        showSheet.toggle()
                                    } label: {
                                        Text("More Details")
                                            .foregroundStyle(.black)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding(.bottom, 130)
                                    .halfSheet(showSheet: $showSheet){
                                        ZStack{
                                            LinearGradient(gradient: Gradient(colors: [.black, .red]), startPoint: .top, endPoint: .bottom)
                                            
                                            VStack{
                                                Image(systemName: "chevron.compact.down")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(.white)
                                                    .frame(height: 20)
                                                    .padding(.top, 30)
                                                
                                                ScrollView{
                                                    VStack{
                                                        HStack{
                                                            Text("Description")
                                                                .font(.title)
                                                                .bold()
                                                                .foregroundStyle(.white)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.leading, 20)
                                                        
                                                        Text(agent.description)
                                                            .multilineTextAlignment(.center)
                                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                                            .offset(y: 10)
                                                            .foregroundStyle(.white)
                                                        
                                                        HStack{
                                                            Text("Role")
                                                                .font(.title)
                                                                .bold()
                                                                .foregroundStyle(.white)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                                                        
                                                        HStack{
                                                            AsyncImage(url: URL(string: agent.role?.displayIcon ?? "Unknown")) { image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(height: 40)
                                                            } placeholder: {
                                                                Color.red
                                                            }
                                                            
                                                            Text(agent.role?.displayName.rawValue ?? "Unknown")
//                                                                .bold()
                                                                .font(.title2)
                                                                .foregroundStyle(.white)
                                                                .padding(.leading, 3)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.leading, 40)
                                                        
                                                        HStack{
                                                            Text("Abilities")
                                                                .font(.title)
                                                                .bold()
                                                                .foregroundStyle(.white)
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 0))
                                                        
                                                        ForEach(agent.abilities, id: \.slot){ ability in
                                                            
                                                            HStack{
                                                                VStack{
                                                                    AsyncImage(url: URL(string: ability.displayIcon ?? "Unknown")) { image in
                                                                        image
                                                                            .resizable()
                                                                            .scaledToFit()
                                                                            .frame(height: 55)
                                                                    } placeholder: {
                                                                        Color.red
                                                                    }
                                                                    
                                                                    Spacer()
                                                                }
                                                                
                                                                VStack{
                                                                    
                                                                    HStack {
                                                                        Text(ability.displayName)
                                                                            .bold()
                                                                            .font(.title2)
                                                                            .foregroundStyle(.white)
                                                                            .padding(.leading, 3)
                                                                        .multilineTextAlignment(.leading)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    Text(ability.abilityDescription)
                                                                        .foregroundStyle(.white)
                                                                        .padding(.leading, 3)
                                                                        .offset(y: 5)
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                            }
                                                            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                                                            
                                                        }
                                                        .padding(.top, 5)
                                                        
                                                    }
                                                    .padding(.bottom, 10)
                                                }
                                                
                                                Spacer()
                                            }
                                            
                                        }
                                        .ignoresSafeArea()
                                        
                                        
                                    }

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
                                .frame(height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                
                                Text(agent.role?.displayName.rawValue ?? "Unknown")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 5)
                                
                                Image(systemName: favoritedAgents.contains(agent.displayName) ? "star.fill" : "star")
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
                .padding(10)
                .shadow(radius: 5)
                
                Spacer()
                
            }
            .onAppear(){
                modelData.fetchData()
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

extension View{
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView)-> some View{
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable{
    var sheetView: SheetView
    @Binding var showSheet: Bool
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet{
            let sheetController = UIHostingController(rootView: sheetView)
            
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
}
