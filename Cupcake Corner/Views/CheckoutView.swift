//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 24/06/2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    
    var body: some View {
        //User Geometry Reader to properly resize image
        GeometryReader{ geo in
            ScrollView{
                VStack(alignment: .center){
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Section{
                        
                        Text("Total: £ \(self.order.cost, specifier: "%.2f")")
                        
                        Text("Delivery Fee: £3.50")
                        
                        Text("Order Total: £ \(self.order.totalCost, specifier: "%.2f")")
                    }
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                    
                    Button("Place Order"){
                        //Place the order
                        self.sendOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    func sendOrder(){
        
        //use json encoder to archive data from Order() into JSON
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode the oder")
            return
        }
        
        //URLRequest
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcake(s) is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
