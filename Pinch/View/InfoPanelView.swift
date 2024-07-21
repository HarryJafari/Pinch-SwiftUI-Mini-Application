//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Reza on 20/7/2024.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale: CGFloat
    var offset: CGSize
    @State private var isInfoPanelVisible: Bool = false
    
    var body: some View {
        
        // MARK: INFO panel Button
        HStack {
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30 , height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeInOut(duration: 1)){
                        isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK: Panel
            
            HStack(spacing: 2) {
                Spacer()
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                Spacer()
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 420)
                .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        } // Enf of HStack Main
    }
}

#Preview {
    InfoPanelView(scale: 1, offset: .zero)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
