//
//  ContentView.swift
//  CakeBaker
//
//  Created by Khawlah Khalid on 25/09/2024.
//

import SwiftUI

struct Cake: Identifiable{
    let name: String
    let flour: Double
    let sugar: Double
    let eggs: Int
    
    let id: UUID = .init()
}

struct ContentView: View {
    let appName: String = "Cake Baker"
    @State var cakeName: String = ""
    @State var flour: Double = 2.5
    @State var sugar: Double = 1.25
    @State var eggs: Int = 3
    @State var isActive = true
    @State var showAddCakeSheet = false

    @State var cakes: [Cake] = [ .init(name: "Chocolate cake" , flour: 2.5, sugar: 1.25, eggs: 3)]

    var body: some View {
        NavigationStack {
            Group{
                if isActive{
                    VStack{
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    withAnimation {
                                        self.isActive = false
                                    }
                                }
                            }
                        Text(appName)
                            .foregroundStyle(Color.gray)
                            .bold()
                    }
                }
                else{
                    List{
                        ForEach(self.cakes){ cake in
                            VStack(alignment: .leading){
                                Text(cake.name)
                                    .bold()
                                    .padding(.bottom)
                                HStack{
                                    Text("\(Int(cake.flour)) flour")
                                    Spacer()
                                    Text("\(Int(cake.sugar)) sugar")
                                    Spacer()
                                    Text("\(cake.eggs) egg(s)")
                                }
                                .foregroundStyle(Color.gray)
                            }
                            
                        }
                        
                    }
                    .navigationTitle("My cakes")
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                showAddCakeSheet.toggle()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }}
                    .sheet(isPresented: $showAddCakeSheet, content: {
                        NavigationStack {
                            VStack(alignment: .leading) {
                                
                                TextField("Cake Name", text: $cakeName)
                                TextField("Flour (cups)", value: $flour, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                TextField("Sugar (cups)", value: $sugar, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                TextField("Eggs", value: $eggs, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                
                                
                                Button(action: {
                                    addCake()
                                }) {
                                    HStack{
                                        Spacer()
                                        Text("Save")
                                            .bold()
                                            .foregroundStyle(Color.white)
                                            .padding()
                                        
                                        Spacer()
                                    }
                                    .background{Color.orange}
                                    .clipShape(Capsule())
                                    .padding(.vertical)
                                    
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .textFieldStyle(.roundedBorder)
                            .navigationTitle("Add cake")
                            .navigationBarTitleDisplayMode(.inline)
                            
                        }
                    })
                }
            }
        }
    }
    
    
    func addCake(){
        let newCake: Cake = Cake(name: cakeName, flour: flour, sugar: sugar, eggs: eggs)
        
        self.cakes.append(newCake)
        showAddCakeSheet.toggle()
    }
}

#Preview {
    ContentView()
}
