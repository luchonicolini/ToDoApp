//
//  Categoria+CoreDataProperties.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//
//

import Foundation
import CoreData


extension Categoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categoria> {
        return NSFetchRequest<Categoria>(entityName: "Categoria")
    }

    @NSManaged public var fecha: Date?
    @NSManaged public var nombre: String?
    @NSManaged public var producto: NSSet?

}

// MARK: Generated accessors for producto
extension Categoria {

    @objc(addProductoObject:)
    @NSManaged public func addToProducto(_ value: Producto)

    @objc(removeProductoObject:)
    @NSManaged public func removeFromProducto(_ value: Producto)

    @objc(addProducto:)
    @NSManaged public func addToProducto(_ values: NSSet)

    @objc(removeProducto:)
    @NSManaged public func removeFromProducto(_ values: NSSet)

}

extension Categoria : Identifiable {

}
