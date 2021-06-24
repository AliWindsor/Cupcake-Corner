//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 01/06/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                        
                    }

                    Stepper(value: $order.quantity, in: 0...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                HStack(spacing: 230){
                    Text("Total: ")
                    
                    Text("£ \(self.order.cost, specifier: "%.2f")")
                        .foregroundColor(.gray)
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }

            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
