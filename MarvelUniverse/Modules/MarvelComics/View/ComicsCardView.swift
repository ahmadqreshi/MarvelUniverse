//
//  ComicsCardView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct ComicsCardView: View {
    var body: some View {
        ZStack() {
            ImageAsset.demo.set
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
            VStack {
                HStack {
                    Spacer()
                    Text("2.33$")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .padding([.trailing, .top], 10)
                }
                Spacer()
                Text("Avengers")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text("Pages 190")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
            }
            
        }
        .frame(width: getRect().width/2 - 20, height: 200, alignment: .top)
    }
}

struct ComicsCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsCardView()
    }
}
