//
//  User.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 27/05/2021.
//

import Foundation

class User: ObservableObject, Codable{
    @Published var name = "Alicia Windsor"
    
    enum CodingKeys: CodingKey{ //this lists all properties that we want to archive and unarchive
        case name
    }
    
    //container used to read values
    required init(from decoder: Decoder) throws { //instance of Decoder type
        //when this is called with User() as a subclass, the init must be overridden for custom values, this is marked using "required", "final" may also be used in order to stop subclassing [final class User (init) instead of class User (required init)]
        
        let container = try decoder.container(keyedBy: CodingKeys.self)//container matching all codingkey values [the data should have a container where the keys match whatever cases we have in our enum]. Call is thrown incase data is non-existant.
        
        name = try container.decode(String.self, forKey: .name)//read values by referencing cases in enum. String.self = makes it clear the datatype we are looking for .name = lesser chance of typos

    }
    
     //encoder used to write values
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(name, forKey: .name)
     }
    
   
}
