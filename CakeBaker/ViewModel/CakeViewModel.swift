//
//  CakeViewModel.swift
//  CakeBaker
//
//  Created by Khawlah Khalid on 29/09/2024.
//

import Foundation

final class CakeViewModel: ObservableObject{
    @Published var cakeName: String = ""
    @Published var flour: Double = 2.5
    @Published var sugar: Double = 1.25
    @Published var eggs: Int = 3
    @Published var isActive = true
    @Published var showAddCakeSheet = false

    @Published var cakes: [Cake] = [ .init(name: "Chocolate cake" , flour: 2.5, sugar: 1.25, eggs: 3)]

    
    func addCake(){
        let newCake: Cake = Cake(name: cakeName, flour: flour, sugar: sugar, eggs: eggs)
        
        self.cakes.append(newCake)
        showAddCakeSheet.toggle()
    }
}
