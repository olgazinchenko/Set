//
//  Card.swift
//  Set
//
//  Created by Ольга on 18.06.2021.
//

import Foundation

import UIKit

struct Card: Equatable, CustomStringConvertible {
    var description: String {
        return "\(color), \(shape), \(shade), \(numberOfShapes),"
    }
    
    var identifier: Int
    var color: Variant  
    var shade: Variant
    var shape: Variant
    var numberOfShapes: Variant
    var isSelected = false
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color
            && lhs.shade == rhs.shade
            && lhs.shape == rhs.shape
            && lhs.numberOfShapes == rhs.numberOfShapes
    }

    enum Variant: Int, CustomStringConvertible {
        case v1 = 0
        case v2 = 1
        case v3 = 2
        
        static var allVariants: [Variant] {
            return [.v1, .v2, .v3]
        }
        
        var description: String {
            return String(self.rawValue)
        }
    }
    
}
