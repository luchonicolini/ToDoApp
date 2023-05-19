//
//  Producto+CoreDataProperties.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//
//

import Foundation
import CoreData


extension Producto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producto> {
        return NSFetchRequest<Producto>(entityName: "Producto")
    }

    @NSManaged public var isFavorito: Bool
    @NSManaged public var productos: String?
    @NSManaged public var id: UUID?
    @NSManaged public var categoria: Categoria?

}

extension Producto : Identifiable {

}
