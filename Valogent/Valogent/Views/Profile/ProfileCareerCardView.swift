//
//  ProfileCareerCardView.swift
//  Valogent
//
//  Created by Timothy Kristanto on 19/05/22.
//

import SwiftUI

struct ProfileCareerCardView: View {
    var status: String
    
    var body: some View {
        ZStack{
            Image(status)
                .resizable()
                .scaledToFit()
        }
    }
}

struct ProfileCareerCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCareerCardView(status: "victory")
            .previewLayout(.fixed(width: 300, height: 150))
    }
}
