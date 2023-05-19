//
//  DetailView.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
   
    @FetchRequest(entity: Producto.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Producto.id, ascending: true)])
    private var productos: FetchedResults<Producto>
    let categoria: Categoria
    @State private var nuevoProducto: String = ""
    @State private var showAlert = false
    
    private func addProducto() {
        withAnimation {
            let producto = Producto(context: viewContext)
            producto.productos = nuevoProducto
            producto.categoria = categoria
            
            do {
                try viewContext.save()
                nuevoProducto = ""
            } catch {
                print("Error adding product: \(error.localizedDescription)")
            }
        }
    }

    private func deleteProducto(producto: Producto) {
        withAnimation {
            viewContext.delete(producto)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           // print("Error deleting product: \(error.localizedDescription)")
        }
    }
    

  
    private func deleteAllProductos() {
        showAlert = true
    }

    private func performDeleteAllProductos() {
        withAnimation {
            productos.filter { $0.categoria == categoria }.forEach { producto in
                viewContext.delete(producto)
            }
            
            do {
                try viewContext.save()
            } catch {
                print("Error deleting all products: \(error.localizedDescription)")
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(productos.filter { $0.categoria == categoria }, id: \.self) { producto in
                    HStack {
                        Text(producto.productos ?? "")
                            .strikethrough(producto.isFavorito)
                        Spacer()
                        Image(systemName: producto.isFavorito ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(producto.isFavorito ? .green : .gray)
                            .onTapGesture {
                                withAnimation {
                                    producto.isFavorito.toggle()
                                    try? viewContext.save()
                                }
                            }
                    }
                }
                //.onDelete(perform: deleteProducto)
                HStack {
                    TextField("Nuevo producto", text: $nuevoProducto)
                    Button(action: addProducto) {
                        //Text("Agregar")
                        Image(systemName: "plus")
                    }
                    .disabled(nuevoProducto.isEmpty)
                }
            }
            .navigationTitle(categoria.nombre ?? "")
            .navigationBarItems(trailing:
                Button(action: deleteAllProductos) {
                    Image(systemName: "trash")
                    .foregroundColor(Color.white).bold()
                }
            )
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(title: Text("¿Eliminar todos los productos?"), message: Text("Esta acción no puede deshacerse"), buttons: [
                .destructive(Text("Eliminar"), action: performDeleteAllProductos),
                .cancel()
            ])
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let categoria = Categoria(context: context)
        categoria.nombre = "Productos"
        
        return DetailView(categoria: categoria)
            .environment(\.managedObjectContext, context)
    }
}
