//
//  LastRowView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 13/10/23.
//

import SwiftUI

struct LastRowView: View {
    var body: some View {
        ZStack(alignment: .center) {
            ProgressView()
        }
        .frame(maxHeight: 50)
    }
}

struct LastRowView_Previews: PreviewProvider {
    static var previews: some View {
        LastRowView()
    }
}
