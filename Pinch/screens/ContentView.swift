//
//  ContentView.swift
//  Pinch
//
//  Created by Reza on 20/7/2024.
//

import SwiftUI

// MARK: - Content
struct ContentView: View {
    
    // MARK: Properties
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = CGSize(width: 0, height: 0)
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    //MARK: Functions
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                // MARK: Page Image
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12 , x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .offset(x: imageOffset.width , y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2 ,perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }else {
                            resetImageState()
                        }
                    })
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                                
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    if imageScale <= 1 {
                                      resetImageState()
                                    }
                                   
                                }
                                
                            }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    }else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                    
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                }else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        )
                
            } //MARK: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top,30), alignment: .top)
            .overlay(
                Group {
                    HStack {
                        Button{
                            
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        }label: {
                            ControllImageView(icon: "minus.magnifyingglass")
                        }
                        Button{
                            resetImageState()
                        }label: {
                            ControllImageView(icon:
                                                "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        Button{
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    if imageScale > 5 {
                                         imageScale = 5
                                    }
                                }
                            }
                        }label: {
                            ControllImageView(icon: "plus.magnifyingglass")
                        }
                    }.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom,30)
                ,alignment: .bottom
            )
            // MARK: Drawer
            .overlay(
                HStack(spacing: 12) {
                    
                    Image(systemName:isDrawerOpen ? "chevron.compact.right": "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    
                    Spacer()
                    // MARK: Thumbnail
                    
                    ForEach(pages) { item in
                        Image(item.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 :0)
                            .animation(.easeOut(duration: 1) , value: isDrawerOpen)
                            .onTapGesture(perform: {
                                isAnimating = true
                                pageIndex = item.id
                                isDrawerOpen.toggle()
                            })
                        
                    }
                    
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 290)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 30 : 250)
                ,
                alignment: Alignment.topTrailing
            )
          
        } // MARK: Navigation
        .navigationViewStyle(.stack)
       
    }
}

#Preview {
    ContentView()
}
