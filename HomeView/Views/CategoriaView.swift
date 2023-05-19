//
//  CategoriaView.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import SwiftUI
import CoreData

struct CategoriaView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddView = false
    @State private var searchText = ""
    
    @FetchRequest(entity: Categoria.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Categoria.fecha, ascending: false)], animation: .easeInOut(duration: 0.3))
    private var categorias: FetchedResults<Categoria>
    
    @State private var isLoading = true
    
    private func deleteCategoria(at offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let categoria = categorias[index]
                viewContext.delete(categoria)
            }
            
            do {
                try viewContext.save()
            } catch {
                print("Error deleting categoria: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
         NavigationStack {
             if isLoading {
                 //launcher screen
                 LauncherView()
                     .onAppear {
                         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                             isLoading = false
                         }
                     }
             } else {
                 List {
                     ForEach(categorias.filter { searchText.isEmpty ? true : $0.nombre?.localizedCaseInsensitiveContains(searchText) ?? true }) { categoria in
                         NavigationLink(destination: DetailView(categoria: categoria)) {
                             CategoriaCellView(categoria: categoria)
                         }
                     }
                     .onDelete(perform: deleteCategoria)
                 }
                 .navigationBarTitle("Mi Lista")
                 .sheet(isPresented: $showingAddView) {
                     AddView()
                         .interactiveDismissDisabled()
                         .environment(\.managedObjectContext, viewContext)
                 }
                 .searchable(text: $searchText)
                 .overlay(
                    Floatingbutton(showingAddView: $showingAddView)
                         .padding(.trailing, 20)
                         .padding(.bottom, 20),
                     alignment: .bottomTrailing
                 )
             }
         }
     }
 }



struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaView()
    }
}
