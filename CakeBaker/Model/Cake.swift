//
//  Cake.swift
//  CakeBaker
//
//  Created by Khawlah Khalid on 29/09/2024.
//

import Foundation

struct Cake: Identifiable{
    let name: String
    let flour: Double
    let sugar: Double
    let eggs: Int
    
    let id: UUID = .init()
}
