//
//  Beaufort.swift
//  WiproTask
//
//  Created by Jonathan Saville on 11/06/2017.
//  Copyright © Jonathan Saville. All rights reserved.
//

import Foundation

enum Beaufort {
    
    case Calm
    case LightAir
    case LightBreeze
    case GentleBreeze
    case ModerateBreeze
    case FreshBreeze
    case StrongBreeze
    case NearGale
    case Gale
    case StrongGale
    case Storm
    case ViolentStorm
    case Hurricane
    
    static func fromSpeed(_ speed: Double) -> Beaufort {
        
        switch speed {
        case _ where speed <  1: return Beaufort.Calm
        case _ where speed <  2: return Beaufort.LightAir
        case _ where speed <  3: return Beaufort.LightBreeze
        case _ where speed <  5: return Beaufort.GentleBreeze
        case _ where speed <  8: return Beaufort.ModerateBreeze
        case _ where speed < 11: return Beaufort.FreshBreeze
        case _ where speed < 14: return Beaufort.StrongBreeze
        case _ where speed < 17: return Beaufort.NearGale
        case _ where speed < 21: return Beaufort.Gale
        case _ where speed < 24: return Beaufort.StrongGale
        case _ where speed < 28: return Beaufort.Storm
        case _ where speed < 32: return Beaufort.ViolentStorm
        default: return Beaufort.Hurricane
        }
    }
    
    var description : String {
        
        // English-only at the moment
        
        switch self {
        case .Calm:           return "Calm"
        case .LightAir:       return "Light Air"
        case .LightBreeze:    return "Light Breeze"
        case .GentleBreeze:   return "Gentle Breeze"
        case .ModerateBreeze: return "Moderate Breeze"
        case .FreshBreeze:    return "Fresh Breeze"
        case .StrongBreeze:   return "Strong Breeze"
        case .NearGale:       return "Near Gale"
        case .Gale:           return "Gale"
        case .StrongGale:     return "Strong Gale"
        case .Storm:          return "Storm"
        case .ViolentStorm:   return "Violent Storm"
        case .Hurricane:      return "Hurricane"
        }
    }
}
