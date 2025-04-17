//
//  ImageInterpolation.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 17/04/25.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    ImageInterpolation()
}
