//
//  Errors.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import Foundation

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    init(_ description: String) {
        self.description = description
    }
}
