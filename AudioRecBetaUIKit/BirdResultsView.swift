//
//  ContentView.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.


/// @ObservedObject (protocol) - will be used (not here) inside a view to store an observable object instance and (inside?) the @Published property - before any properties that should trigger change notifications

import SwiftUI

struct BirdResultsView: View {
    @State var birds = [Bird]()
    @Binding var audioURL: URL
    /// variable for loading modal progress view - referencia modalView loading
    @Binding var loading: Bool
    /// for alamofire to not garbage collect API - Storing api instance in view
    let api = Api()
    var body: some View {
        /// I cannot recognize that sound with certainty!
        if  !loading && birds.count == 0 {

            VStack (alignment: .center, spacing: 40){
                Spacer()
                Text("SORRY!")
                    .foregroundColor(.pink)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                Spacer()
                /// *** INSERT 404 IMAGE with this! ***- I cannot recognize that sound with certainty!
                Text("Can't recognize the sound as a bird with certainty")
                Text("BirdNET can't recognize that sound with certainty")
                    .foregroundColor(.pink)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30))
            } /// SORRY - Vstack end
        } else {
            if !loading {
                /// OPTION 1
                                Text(" Results ")
                                    .foregroundColor(.pink)
                                    .font(.title)
                                    .fontWeight(.bold)
//                                    .padding()
                /// OPTION 2
//                HStack {
//                    Image("AviumSonusBirdResults").resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100, alignment: .leading)
                /// maybe add this to image .resizable()
                     ///.scaledToFit().edgesIgnoringSafeArea(.all).opacity(0.9)
                
//                    Text(" Results ")
//                        .foregroundColor(.pink)
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding()
//                } /// *** Hstack end ***
                
                /// HSTACK interval, bird , confidence for title~~~!***** FIX THIS ****
                HStack(alignment: .center) {
                    Text("Interval")
                        .foregroundColor(.pink)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                    Text("Bird Name")
                        .foregroundColor(.pink)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                    Text("Certainty")
                        .foregroundColor(.pink)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                } /// *** Hstack end ***
            } /// if loading - end
        } /// end of else if
        /// moved so it doesn't show all the time but it shows until loading
        ZStack {
            List(birds) {
                        bird in
                        VStack(alignment: .center) {
//                            Text("\(bird.commonName)")
//                        .font(.title3)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .padding(.bottom)
//                          /// to remove spaces from commonName JSON
                            let freedSpaceString = (bird.commonName).filter {!$0.isWhitespace}
                            
                           /// Bird name links to search with image
                            Link("\(bird.commonName)", destination: URL(string: "https://www.google.com/search?q=\(freedSpaceString)")!)
                                .font(.title3)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .padding(.bottom)
                      HStack{
                        Text("\(bird.beginTimeSec) -")
                            .foregroundColor(.pink)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\(bird.endTimeSec) sec")
                            .foregroundColor(.pink)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        //                    Text("\((Float(bird.confidence))!*100) %" as String)
                        //                        .foregroundColor(.orange)
                        //                        .font(.body)
                        //                        .fontWeight(.bold)
                        Text("\(Int(bird.confidence*100)) %" as String)
                            .foregroundColor(.orange)
                            .font(.body)
                            .fontWeight(.bold)
                    } ///   Hstack end
                      .hoverEffect(.lift) /// *** doesn't work *** fix
                    Spacer()
                } ///  Vstack end
                Image("AviumSonusBirdResults")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.9)
            } /// List(birds) end
        } /// zstack end
        .onAppear() {
            /// passing url all the way to upload data which is called when the modal appears which builds a birds result view
            api.uploadData(audioFile: audioURL) {
                /// this executes, once  api call is complete - BUILDING BIRD MODEL TO DISPLAY
                (birds) in self.birds = birds
                debugPrint(self.birds)
                self.loading = false
            } /// **** end of completion api callback ****
        } /// **** onAppear end ***
        .navigationTitle("Bird List") ///  ***try taking this off here***
    } /// end  body
} /// end BirdResultsView
///
///   *********structure (preview for view above!) -- giving me an error!    *********
///  *** make audio url an observable object? ***
//struct BirdResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BirdResultsView(self.birds, $audioURL, self.loading)
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

