//
//  CategoriaCellView.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import SwiftUI

struct CategoriaCellView: View {
    var categoria: Categoria // define the categoria variable
    
    var body: some View {
        // use the categoria variable in the view
        VStack(alignment: .leading, spacing: 6) {
            Text(categoria.nombre ?? "")
                .fontWeight(.semibold)
            Text((categoria.fecha ?? Date()).formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}


