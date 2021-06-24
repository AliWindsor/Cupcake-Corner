//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 27/05/2021.
//

import SwiftUI

struct iTunesContentView: View {
    
    @State public var res = [Result]()
    @State public var term = ""
    var body: some View {
        VStack{
            Text("Search for a song")
            HStack{
                TextField("Search", text: $term)
                Button("Go"){
                    loadData()
                }
            }.padding()
            List(res, id: \.trackId){ item in
                VStack(alignment: .leading){
                    Text(item.trackName)
                    .font(.headline)
                    Text(item.collectionName)
                }
            }
        }
    }
    
    
    func loadData(){
        
        //define the url
        let url = URL(string: "https://itunes.apple.com/search?term=\(term.replacingOccurrences(of: " ", with: "+"))&entity=song")
        
        //define the urlrequest, control how the url is loaded
        let req = URLRequest(url: url!)
        
        //create networking task using urlsession
        URLSession.shared.dataTask(with: req){ data, response, error in
        //can make own session, but shared is often used.
        //data = data retured from req
        // response = description of data
        //if data sent then error not sent and vise versa
            
            //handle result of networking task
            if let data = data{
                do {
                    let decodedRes = try JSONDecoder().decode(Response.self, from: data)
                        
                    //dispatchqueue.main.async sends work to the main thread, async means bg work wont wait for closure to run before added
                        
                        DispatchQueue.main.async {
                            self.res = decodedRes.results
                        }
                        
                        //return
    
               }catch{print(error)}
                
                return
            }
        }
        .resume() //need to call this else the task will not run
       
    }
}

struct iTunesContentView_Previews: PreviewProvider {
    static var previews: some View {
        iTunesContentView()
    }
}
