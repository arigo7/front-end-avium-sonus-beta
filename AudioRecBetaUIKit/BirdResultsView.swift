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
        Text("Bird Results")
            .foregroundColor(.pink)
            .font(.title)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding()
        
        List(birds) {
            bird in
            VStack(alignment: .trailing) {
               
                Text("\(bird.commonName)")
                    .font(.title2)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                
                HStack{
                    Text("\(bird.beginTimeSec) to")
                        .foregroundColor(.pink)
                    Text("\(bird.endTimeSec) sec")
                        .foregroundColor(.pink)
                        Spacer()
                    
                    Text("\((Float(bird.confidence))!*100)%" as String)
                        .foregroundColor(.orange)
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
} // end BirdResultsView

/// change to uploadData above like so?
//            .onAppear() {
//                Api().uploadData { (birds) in self.birds = birds
//            }
//            }.navigationTitle("Bird List")
//    }
//} // end BirdResultsView

// structure (preview for view above!)
struct BirdResultsView_Previews: PreviewProvider {
    static var previews: some View {
        BirdResultsView()
    }
}
