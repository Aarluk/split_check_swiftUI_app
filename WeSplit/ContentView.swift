//
//  ContentView.swift
//  WeSplit
//
//  Created by Virginie Bonnet on 2/24/21.
//

import SwiftUI

//Add background image
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundImage = UIImage(named: "vador2")

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var totalAmount = ""
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountWithTips: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        let totalAmount = orderAmount + tipValue
        
        return totalAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                //SECTION 1
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                //SECTION 2
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                //SECTION 3
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                //SECTION 4
                Section(header: Text("Total Check Amount with Tips")){
                    Text("$\(totalAmountWithTips, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
