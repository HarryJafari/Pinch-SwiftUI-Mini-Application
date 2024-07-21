//
//  ControllImageView.swift
//  Pinch
//
//  Created by Reza on 21/7/2024.
//

import SwiftUI

struct ControllImageView: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 30))
    }
}

#Preview {
    ControllImageView(icon: "minus.magnifyingglass")
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
        .padding()
}
