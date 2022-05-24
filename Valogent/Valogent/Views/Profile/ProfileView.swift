//
//  ProfileView.swift
//  Valogent
//
//  Created by Timothy Kristanto on 19/05/22.
//

import SwiftUI

struct ProfileView: View {
    let careers: [String] = ["victory", "defeat", "victory"]
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack{
                    Image("valorantLogo")
                        .resizable()
                        .ignoresSafeArea()
                        .frame(width: .infinity, height: 190, alignment: .bottom)
                    
                    Spacer()
                }
                
                VStack{
                    Image("sageChar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120, alignment: .top)
                        .padding(10)
                        .background(.red)
                        .cornerRadius(90)
                        .shadow(radius: 8)
                 
                    Text("Mizzen")
                        .font(.largeTitle)
                        .bold()
                    
                    VStack{
                        HStack{
                            Text("Account Information")
                                .font(.title2)
                                .bold()
                                .padding(.top, 10)
                            
                            Spacer()
                        }
                    }
                    .offset(x: 20)
                    
                    HStack{
                        Text("Kills")
                            .bold()
                        Text("45")
                        
                        Text("Deaths")
                            .bold()
                            .padding(.leading, 10)
                        Text("38")
                        
                        Text("Assists")
                            .bold()
                            .padding(.leading, 10)
                        Text("25")
                    }
                    .padding(.top, 8)
                    
                    HStack{
                        VStack{
                            Text("Current Rank")
                                .font(.title3)
                                .bold()
                            Image("platinum-rank")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Platinum I")
                        }
                        
                        Divider()
                            .frame(width: 75, height: 80)
                        
                        VStack{
                            Text("Highest Rank")
                                .font(.title3)
                                .bold()
                            Image("platinum-rank")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            Text("Platinum III")
                        }
                    }
                    .padding(.top, 15)
                    
                    VStack{
                        HStack{
                            Text("Career")
                                .font(.title2)
                                .bold()
//                                .frame(maxWidth: 400, alignment: .leading)
                                .padding(.top, 20)
                            
                            Spacer()
                        }
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(careers, id: \.self){ career in
                                    ProfileCareerCardView(status: career)
                                        .frame(height: 150)
                                        .padding(.leading, 3)
                                }
                            }
                            
                        }
                        .offset(y: 0)
                    }
                    .padding(.leading, 20)
    
                    
                    Spacer()
                    
                    
                }
                .offset(y: 130)
                
            }
            
        }
        .ignoresSafeArea(edges: .top)
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
