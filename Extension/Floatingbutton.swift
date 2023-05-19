//
//  Floatingbutton.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 09/05/2023.
//

import SwiftUI

struct Floatingbutton: View {
    @Binding var showingAddView: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddView = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .frame(width: 70,height: 70)
                            .background(Color("Color"))
                            .clipShape(Circle())
                            .foregroundColor(.white).bold()
                    })
                    .padding()
                    //.shadow(radius: 2)
                }
            }
        }
    }
}


