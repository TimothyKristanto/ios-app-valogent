//
//  FavoriteButton.swift
//  Valogent
//
//  Created by Timothy Kristanto on 22/05/22.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Image(systemName: isSet ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(height: 25)
                .padding(.leading, 5)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
