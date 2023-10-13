//
//  ComicsCardView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicsCardView: View {
    
    var comic: ComicsModel
    
    var thumbnailString: String {
        let path = comic.thumbnail?.path ?? ""
        let securePath = path.replacingOccurrences(of: "http", with: "https")
        let actualPath = securePath.replacingOccurrences(of: #"\"#, with: "")
        let extensionString = comic.thumbnail?.thumbnailExtension ?? ""
        return "\(actualPath).\(extensionString)"
    }
    
    var price: String {
        guard let price = comic.prices?.first else { return "" }
        return "\(price.price)$"
    }
    
    var comicName: String {
        comic.title?.capitalized ?? ""
    }
    
    var pages: String {
        return "Total Pages \(comic.pageCount ?? 0)"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: thumbnailString))
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .cornerRadius(10)
                .frame(height: 200)
            
            Text(comicName)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(price)
                .font(.system(size: 16))
                .foregroundColor(.red)
            
            Text(pages)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
        }
        .frame(width: getRect().width/2 - 20, alignment: .top)
    }
}

struct ComicsCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsCardView(comic: ComicsModel.dummyData())
    }
}
