//
//  LoaderView.swift
//  MarvelUniverse
//
//  Created by Ahmad Qureshi on 10/10/23.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.red)
                .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
