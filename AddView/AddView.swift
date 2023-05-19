//
//  AddView.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var nombre: String = ""
    @State private var fecha: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nueva Categoría")) {
                    TextField("Nombre de la categoría", text: $nombre)
                }
            }
            .navigationBarTitle("Agregar Categoría")
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                }) {
                    Text("Cancelar")
                },
                trailing: Button(action: {
                    addCategoria()
                }) {
                    Text("Guardar")
                }.disabled(nombre.isEmpty)
            )
        }
    }
    
    private func addCategoria() {
        withAnimation {
            let categoria = Categoria(context: viewContext)
            categoria.nombre = nombre
            categoria.fecha = fecha
            do {
                try viewContext.save()
                dismiss()
            } catch {
                print("Error saving categoria: \(error.localizedDescription)")
            }
        }
    }
}



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
