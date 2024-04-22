//
//  WeightClass.swift
//  ufcTop15
//
//  Created by alexis alvarez on 4/19/24.
//

import Foundation

enum WeightClass: String, CaseIterable {
    case mensPfP = "Men's Pound-for-Pound"
    case womensPfP = "Women's Pound-for-Pound"
    case womenStrawweight = "Women's Strawweight"
    case womensFlyweight = "Women's Flyweight"
    case womensBantamweight = "Women's Bantamweight"
    case flyweight = "Flyweight"
    case bantamweight = "Bantamweight"
    case featherweight = "Featherweight"
    case lightweight = "Lightweight"
    case welterweight = "Welterweight"
    case Middleweight = "Middleweight"
    case lightHeavyweight = "Light Heavyweight"
    case Heavyweight = "Heavyweight"
    // Add more weight classes as needed

    static let `default` = mensPfP // Default weight class

}
