//
//  Result.swift
//  TestTecnicoLuizaLabs
//
//  Created by Caio de Almeida Pessoa on 09/08/25.
//

import Foundation

public enum Result<ValueObject, ErrorObject> {
    case none
    case successful(ValueObject)
    case failure(ErrorObject)
    
    public var value:ValueObject? {
        switch self {
        case .successful(let obj):
            return obj
        default:
            return nil
        }
    }
    
    public var error:ErrorObject? {
        
        switch self {
        case .failure(let obj):
            return obj
        default:
            return nil
        }
    }
}
