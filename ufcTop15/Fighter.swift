//
//  Fighter.swift
//  ufcTop15
//
//  Created by alexis alvarez on 4/19/24.
//

import Foundation

struct Fighter: Identifiable {
    let id = UUID()
    let fighter: String
    let rank: Int
    let weightClass: WeightClass
    //let record: String
    //let nickname: String?
}

