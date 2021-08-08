//
//  ContentView.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.
//

import SwiftUI

// structure (view protocol) - view content layout
struct BirdResultsView: View {
    
    @State var birds = [Bird]()
    // Storing api instance in view
    
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        List(birds) {
            bird in
            VStack(alignment: .leading) {
                
                Text("\(bird.commonName)")
                    .font(.title)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                
                HStack{
                    Text("\(bird.confidence)")
                        .font(.body)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            
         }
            .onAppear() {
                Api().loadData { (birds) in self.birds = birds
                }
            }.navigationTitle("Bird List")
    }
}

// structure (preview for view above!)
struct BirdResultsView_Previews: PreviewProvider {
    static var previews: some View {
        BirdResultsView()
    }
}
