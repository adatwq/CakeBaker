//
//  ContentView.swift
//  CakeBaker
//
//  Created by Khawlah Khalid on 09/09/2024.
//



import SwiftUI

struct AddCakeView: View {
    let appName: String = "Cake Baker"
    @State private var cakeName: String = ""
    @State private var flour: Double = 2.5
    @State private var sugar: Double = 1.25
    @State private var eggs: Int = 3
    @State private var isActive = true
    @State private var shouldNavigate = false
    @State private var instructions: String = ""
    @State var cakes: [[String:Any]] = []
    var body: some View {
        
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
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("Add cake")
                        .bold()
                        .foregroundStyle(Color.gray)
                        .padding(.vertical)
                    
                    TextField("Cake Name", text: $cakeName)
                    TextField("Flour (cups)", value: $flour, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    TextField("Sugar (cups)", value: $sugar, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    TextField("Eggs", value: $eggs, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                    
                    Button(action: {
                       // generateInstructions()
                        addCake()
                        shouldNavigate.toggle()
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
                .navigationTitle(appName)
                .navigationDestination(isPresented: $shouldNavigate, destination: {
                    VStack(alignment: .leading){
                        List{
                            ForEach(0..<cakes.count){ index in
                                HStack{
                                    VStack{
                                        Text("\(cakes[index]["cakeName", default: ""])")
                                    }
                                }
                                
                            }
                           
                            
                        }
                        Spacer()
                    }
                    .navigationTitle("Instructions")
                    .navigationBarTitleDisplayMode(.inline)
                })
                
            }
        }
    }
    
    func addCake(){
        let newCake: [String:Any] = ["cakeName":cakeName,
                                     "flour":flour,
                                     "sugar":sugar,
                                     "eggs":eggs]
        self.cakes.append(newCake)
    }
    
//    func generateInstructions() {
//        guard let flourAmount = Double(flour),
//              let sugarAmount = Double(sugar),
//              let eggCount = Int(eggs) else {
//            instructions = "Please enter valid ingredient amounts."
//            return
//        }
//        
//        instructions = "To bake a \(cakeName):\n\n" +
//        "1. Preheat your oven to 350°F (175°C).\n\n" +
//        "2. In a mixing bowl, combine \(flourAmount) cups of flour, \(sugarAmount) cups of sugar, and \(eggCount) eggs.\n\n" +
//        "3. Mix until smooth and pour into a greased cake pan.\n\n" +
//        "4. Bake for approximately \(bakingTime(eggCount)) minutes or until a toothpick comes out clean.\n\n" +
//        "5. Let it cool before serving. Enjoy your \(cakeName)!"
//        
//    }
    
    func bakingTime(_ eggCount: Int) -> Int {
        return 25 + (eggCount * 5) // Basic time calculation
    }
    
}


#Preview {
    AddCakeView()
}

