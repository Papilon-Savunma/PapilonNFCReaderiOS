//
//  NotImplementedDG.swift
//  
//
//  Created by Papilon Savunma on 11.01.2022.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public class NotImplementedDG : DataGroup {
    required init( _ data : [UInt8] ) throws {
        try super.init(data)
        datagroupType = .Unknown
    }
}
