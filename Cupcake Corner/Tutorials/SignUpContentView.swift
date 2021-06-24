//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 01/06/2021.
//

import SwiftUI

struct SignUpContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
  

        var body: some View {
            Form {
                Section {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                }

                Section {
                    Button("Create account") {
                        print("Creating account…")
                    }
                }
                
                //.disabled(username.isEmpty || email.isEmpty)
                .disabled(disableForm)
            }
            
        }
 
    
  
}

struct SignUpContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpContentView()
            //SignUpContentView()
        }
    }
}
