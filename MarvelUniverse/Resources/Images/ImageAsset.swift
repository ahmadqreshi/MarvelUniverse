//
//  ImageAsset.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

enum ImageAsset: String {
    case launchImage
    case demo
    
    var set: Image {
        return Image(self.rawValue)
    }
}
