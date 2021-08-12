//
//  ContentView.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.
//


// @ObservedObject (protocol) - will be used (not here) inside a view to store an observable object instance and (inside?) the @Published property - before any properties that should trigger change notifications

import SwiftUI
// I think I need to import UIKit here which I think is my ViewController to handle push from ResultsView (ViewController2) into ContentView (ViewController1) which is my main view where I'll push my results of the API call

// structure (view protocol) - view content layout
struct BirdResultsView: View {
    
    @State var birds = [Bird]()
    @Binding var audioURL: URL
    @State var loading: Bool = false
    // for alamofire to not garbage collect API
    let api = Api()
    // Storing api instance in view
    
    var body: some View {
        Text("Bird Results")
            .foregroundColor(.pink)
            .font(.title)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding()
        if loading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                .scaleEffect(3)
        } else {
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
                loading = true
                // passing url all the way to upload data which is called when the modal appears which builds a birds result view
                api.uploadData(audioFile: audioURL) { (birds) in self.birds = birds }
                loading = false
            }.navigationTitle("Bird List")
            
    }
    }
} // end BirdResultsView

/// change to uploadData above like so?
//            .onAppear() {
//                Api().uploadData { (birds) in self.birds = birds
//            }
//            }.navigationTitle("Bird List")
//    }
//} // end BirdResultsView

// structure (preview for view above!) -- giving me an error! 

//struct BirdResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BirdResultsView()
//    }
//}

