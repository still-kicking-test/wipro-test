//
//  Cardinal.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

enum Cardinal : String {
    
    case North      = "N"
    case NorthEast  = "NE"
    case East       = "E"
    case SouthEast  = "SE"
    case South      = "S"
    case SouthWest  = "SW"
    case West       = "W"
    case NorthWest  = "NW"
    
    static func fromDirection(_ degrees: Double) -> Cardinal {
        
        let cardinals: [Cardinal] = [.North,
                                     .NorthEast,
                                     .East,
                                     .SouthEast,
                                     .South,
                                     .SouthWest,
                                     .West,
                                     .NorthWest,
                                     .North ]
        
        let index = Int(round(Double(degrees).truncatingRemainder(dividingBy: 360) / 45))
        return cardinals[index]
    }
    
    var description : String {
        switch self {
        // English-only at the moment
        case .North:     return "North"
        case .NorthEast: return "NorthEast"
        case .East:      return "East"
        case .SouthEast: return "SouthEast"
        case .South:     return "South"
        case .SouthWest: return "SouthWest"
        case .West:      return "West"
        case .NorthWest: return "NorthWest"
        }
    }
}
