//
//  ScaledMaskModifier.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import Foundation
import SwiftUI

struct ScaledMaskModifier<Mask: View>: ViewModifier {
    
    func calculateSize(geometry: GeometryProxy) -> CGFloat {
        if geometry.size.width > geometry.size.height {
            return geometry.size.width
        }
        return geometry.size.height
    }
    
    var mask: Mask
    var progress: CGFloat
    
    func body(content: Content) -> some View {
        content
            .mask(GeometryReader(content: { geometry in
                self.mask.frame(width: self.calculateSize(geometry: geometry) * self.progress,
                                height: self.calculateSize(geometry: geometry) * self.progress,
                                alignment: .center)
            }))
    }
}

struct LoadingView<Content: View>: View {

    var content: Content
    @Binding var progress: CGFloat
    @State var logoOffset: CGFloat = 0 //Animation Y Offset
    
    var body: some View {
        content
            .modifier(ScaledMaskModifier(mask: Circle(), progress: progress))
            .offset(x: 0, y: logoOffset)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    self.progress = 1.0
                }
                withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                    self.logoOffset = 10
                }
            }
    }
}


struct LauncherView: View {

    @State var progress: CGFloat = 0
    @State var doneLoading: Bool = false
    
    var body: some View {
        ZStack {
            if doneLoading {
                CategoriaView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
            } else {
                LoadingView(content: Image("launcher")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100,height: 100)
                                        .padding(.horizontal, 50),
                            progress: $progress)
                    // Added to simulate asynchronous data loading
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.progress = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation {
                                    self.doneLoading = true
                                }
                                
                            }
                        }
                    }
            }
        }
    }
}
