//
//  Card.swift
//  Set
//
//  Created by Ольга on 18.06.2021.
//

import Foundation

import UIKit

struct Card: Equatable {
    var identifier: Int
    var color: UIColor
    var shape: Character
    var numberOfShapes: Int
    var isSelected: Bool = false
}
