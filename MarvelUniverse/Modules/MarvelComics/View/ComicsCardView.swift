//
//  ComicsCardView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsCardView: View {
    
    //var comic: ComicsModel
    
//    var thumbnailString: String {
//        let path = comic.thumbnail?.path ?? ""
//        let securePath = path.replacingOccurrences(of: "http", with: "https")
//        let actualPath = securePath.replacingOccurrences(of: #"\"#, with: "")
//        let extensionString = character.thumbnail?.thumbnailExtension ?? ""
//        return "\(actualPath).\(extensionString)"
//    }
//
    
    var body: some View {
        ZStack() {
            WebImage(url: URL(string: "thumbnailString"))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
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

//struct ComicsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicsCardView()
//    }
//}
