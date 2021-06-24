//
//  Order.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 01/06/2021.
//

import Foundation
import SwiftUI

class Order: ObservableObject, Codable{
    
    init() {}
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    //Published listens for changes to the variables and updates them in the view
    
    //Order Details
    @Published var type = 0
    @Published var quantity = 0
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false {
               extraFrosting = false
               addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    //Order Costs
    var cost: Double{
        //£2 per cupcake
        var cost = Double(quantity) * 2
        
        //complicated (rainbow in this case) cupcakes cost more
        if type == 3{
            cost += (Double(type) / 2)
        }
        
        //£1 per cupcake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //£0.50p per cupcake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    //Delivery Costs
    var totalCost: Double{
        return cost + 3.50
    }
    
    //Address Details
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    //Address Validation
    var hasValidAddress: Bool{
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    //Conforming to Codable
    enum CodingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles,  name, streetAddress, city, zip
    }
    
    //throws means we dont need to worry about error handling for each try statement in the func
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    
}
