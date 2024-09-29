//
//  ContentView.swift
//  CakeBaker
//
//  Created by Khawlah Khalid on 25/09/2024.
//

import SwiftUI


struct ContentView: View {
    let appName: String = "Cake Baker"
    @StateObject var cakeViewModel = CakeViewModel()
    
    var body: some View {
        NavigationStack {
            Group{
                if cakeViewModel.isActive{
                    VStack{
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    withAnimation {
                                        cakeViewModel.isActive = false
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
                        ForEach(cakeViewModel.cakes){ cake in
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
                                cakeViewModel.showAddCakeSheet.toggle()
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }}
                    .sheet(isPresented: $cakeViewModel.showAddCakeSheet, content: {
                        NavigationStack {
                            VStack(alignment: .leading) {
                                
                                TextField("Cake Name", text: $cakeViewModel.cakeName)
                                TextField("Flour (cups)", value: $cakeViewModel.flour, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                TextField("Sugar (cups)", value: $cakeViewModel.sugar, formatter: NumberFormatter())
                                    .keyboardType(.decimalPad)
                                TextField("Eggs", value: $cakeViewModel.eggs, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                
                                
                                Button(action: {
                                    cakeViewModel.addCake()
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
    
    

}

#Preview {
    ContentView()
}
