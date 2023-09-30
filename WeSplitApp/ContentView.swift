//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Shubham on 29/09/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var totalAmountEnteredByUser = 0.0
    @State private var selectedNumberOfPeople = 2
    @State private var selectedTipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 25, 0]
    let currentCurrency: String = Locale.current.currency?.identifier ?? "USD"
    
    
    private var totalFinalAmountToPay: Double {
        // Total amount to pay
        let peopleCount = Double(selectedNumberOfPeople + 2)
        let tipSelection = Double(selectedTipPercentage)
        let tipValue = (totalAmountEnteredByUser / 100) * tipSelection
        let grandTotal = totalAmountEnteredByUser + tipValue
        
        return grandTotal
    }

    private var totalFinalAmountToPayPerPerson: Double {
        // Total amount to pay
        let peopleCount = Double(selectedNumberOfPeople + 2)
        let tipSelection = Double(selectedTipPercentage)
        let tipValue = (totalAmountEnteredByUser / 100) * tipSelection
        let grandTotal = totalAmountEnteredByUser + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                // Section - 1 - Enter the amount and number of people
                Section {
                    TextField("Enter the amount to split", value: $totalAmountEnteredByUser, format: .currency(code: currentCurrency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $selectedNumberOfPeople) {
                        ForEach(2..<100) { count in
                            Text("\(count) People")
                        }
                    }
                }
                
                
                // Section - 2 - Enter the tip percentage to give
                Section {
                    Picker("Select Tip Percentage", selection: $selectedTipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select the tip percentage")
                }
                
                Section {
                    Text(totalFinalAmountToPay, format: .currency(code: currentCurrency))
                        .foregroundStyle((selectedTipPercentage == 0) ? Color.red : Color.primary)
                } header: {
                    Text("Total amount")
                }
                
                
                // Section - 3 - Final Output
                Section {
                    Text(totalFinalAmountToPayPerPerson, format: .currency(code: currentCurrency))
                } header: {
                    Text("Amount Per Person")
                }
            }
            
            .navigationTitle("We Split App")
            .toolbar {
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
