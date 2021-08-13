//
//  ContentView.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.

/// TRYING THIS NOW ------------------------------------------------------------------------------------------------
///

/// @ObservedObject (protocol) - will be used (not here) inside a view to store an observable object instance and (inside?) the @Published property - before any properties that should trigger change notifications

import SwiftUI

struct BirdResultsView: View {
    @State var birds = [Bird]()
    @Binding var audioURL: URL
    
    /// variable for loading modal progress view
    /// referencia modalView loading
    @Binding var loading: Bool

    /// for alamofire to not garbage collect API
    /// Storing api instance in view
    let api = Api()
    
    var body: some View {
//        if loading {

//        } else {
            /// moved so it doesn't show all the time but it shows until loading
            Text("Bird Results")
                .foregroundColor(.pink)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
        
            /// ********** SOO NEED need to implement *********
            /// if list is empty, show someting, else show '
            /// this :
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
                    
                } ///   Hstack end
                Spacer()
            } ///  Vstack end
            
         } // List(birds) end
            .onAppear() {
                /// passing url all the way to upload data which is called when the modal appears which builds a birds result view
                api.uploadData(audioFile: audioURL) {
                    /// this executes, once  api call is complete
                    /// BUILDING BIRD MODEL TO DISPLAY
                    (birds) in self.birds = birds
                    
                    self.loading = false
                }
//
            } ///  ***try taking this off here - WHERE IS IT PRINTING>??? ***
            .navigationTitle("Bird List") ///  ***try taking this off here***
//        } /// end conditional
    } /// end  body
} /// end BirdResultsView
///
///
///   *********structure (preview for view above!) -- giving me an error!    *********

//struct BirdResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BirdResultsView()
//    }
//}
///
/// *******/// END OF TRIAL ********** ----------------------------------------------------------------------------------------------------
//
/// BACK UP!  - starts here --------------------------------------------------------------------------------

// @ObservedObject (protocol) - will be used (not here) inside a view to store an observable object instance and (inside?) the @Published property - before any properties that should trigger change notifications

// import SwiftUI
// I think I need to import UIKit here which I think is my ViewController to handle push from ResultsView (ViewController2) into ContentView (ViewController1) which is my main view where I'll push my results of the API call

// structure (view protocol) - view content layout

//struct BirdResultsView: View {
//
//    @State var birds = [Bird]()
//    @Binding var audioURL: URL
//    @State var loading: Bool = false
//    // for alamofire to not garbage collect API
//    let api = Api()
//    // Storing api instance in view
//
//    var body: some View {
//        Text("Bird Results")
//            .foregroundColor(.pink)
//            .font(.title)
//            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//            .padding()
//        if loading {
//            ProgressView()
//                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
//                .scaleEffect(3)
//        } else {
//        List(birds) {
//            bird in
//            VStack(alignment: .trailing) {
//
//                Text("\(bird.commonName)")
//                    .font(.title2)
//                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                    .padding(.bottom)
//
//                HStack{
//                    Text("\(bird.beginTimeSec) to")
//                        .foregroundColor(.pink)
//                    Text("\(bird.endTimeSec) sec")
//                        .foregroundColor(.pink)
//                        Spacer()
//
//                    Text("\((Float(bird.confidence))!*100)%" as String)
//                        .foregroundColor(.orange)
//                        .font(.body)
//                        .fontWeight(.bold)
//
//                }
//                Spacer()
//            }
//
//         }
//            .onAppear() {
//                loading = true
//                // passing url all the way to upload data which is called when the modal appears which builds a birds result view
//                api.uploadData(audioFile: audioURL) { (birds) in self.birds = birds }
//                loading = false
//            }.navigationTitle("Bird List")
//
//      } // end of else
//    } // end of body
//} // end BirdResultsView

// ----------------------------------------------------------------
/// change to uploadData above like so?
//            .onAppear() {
//                Api().uploadData { (birds) in self.birds = birds
//            }
//            }.navigationTitle("Bird List")
//    }
//} // end BirdResultsView

// ----------------------------------------------------------------

// structure (preview for view above!) -- giving me an error! 

//struct BirdResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BirdResultsView()
//    }
//}

