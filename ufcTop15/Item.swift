//
//  Item.swift
//  ufcTop15
//
//  Created by alexis alvarez on 4/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
