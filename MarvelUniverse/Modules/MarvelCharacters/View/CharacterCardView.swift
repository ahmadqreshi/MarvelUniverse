//
//  CharacterCardView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCardView: View {
    var character: CharactersModel
    
    var thumbnailString: String {
        let path = character.thumbnail?.path ?? ""
        let securePath = path.replacingOccurrences(of: "http", with: "https")
        let actualPath = securePath.replacingOccurrences(of: #"\"#, with: "")
        let extensionString = character.thumbnail?.thumbnailExtension ?? ""
        return "\(actualPath).\(extensionString)"
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: URL(string: thumbnailString))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .cornerRadius(10)
            
            Text(character.name ?? "")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
        .frame(width: getRect().width/2 - 20, height: 200, alignment: .top)
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(character: CharactersModel(
            thumbnail: nil,
            id: nil,
            stories: nil,
            comics: nil,
            series: nil,
            events: nil,
            urls: nil,
            name: nil,
            resourceURI: nil,
            description: nil))
    }
}
