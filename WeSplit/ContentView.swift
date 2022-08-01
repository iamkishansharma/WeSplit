//
//  TipCalculator.swift
//  Wiseyak
//
//  Created by Kishan Kr Sharma on 7/30/22.
//

//import Foundation

import SwiftUI
struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    
    @FocusState private var amountIsFocused:Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double{
        // calculate the totlal per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal  = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View{
        NavigationView{
            Form{
                Section{
                    TextField("Amount",value: $checkAmount, format:
                              .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<20){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("How much tip you want to leave?")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(width: 300, height: nil, alignment: .center)
                }header: {
                    Text("Each person should pay")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
