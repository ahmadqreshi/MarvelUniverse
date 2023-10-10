//
//  CharacterCardView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct CharacterCardView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageAsset.demo.set
                .resizable()
                .scaledToFill()
                .frame(width: getRect().width/2 - 30, height: 200, alignment: .top)
                .clipped()
                .cornerRadius(10)
            
            Text("Captain America")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView()
    }
}
