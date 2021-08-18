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
        //        if  !loading && birds.count == 0 {
        if  !loading && birds.count == 0 {
            //            VStack (alignment: .center, spacing: 5){
            VStack (alignment: .center, spacing: 15){
                Spacer()
                Text("Oops!")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                //                Spacer()
                
                Text("BirdNET can't recognize the sound")
                    .foregroundColor(.black)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30))
                    .padding()
                Spacer()
                Spacer()
                Spacer()
                
                /// *** 404  Results - IMAGE  ***- Cannot recognize sound with certainty
                Image("SorryResults4")
                    .resizable()
                    .frame(width: 275, height: 275, alignment: .center)
                Spacer(minLength: 10)
            } /// SORRY results- Vstack end
            .frame(minWidth: 410, idealWidth: 415, maxWidth: .infinity, minHeight: 600, idealHeight: 600, maxHeight: .infinity, alignment: .center)
            .background(Color(#colorLiteral(red: 0.121771539, green: 0.9858927693, blue: 0.7137254902, alpha: 0.4240931024))).opacity(0.9)
        } else {
            if !loading {
                
                Text(" Results ")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                
            } /// if loading - end
        } /// end of else if
        /// shows until loaded
        ZStack {
            List(birds) {
                bird in
                VStack(alignment: .center) {
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
///   *********structure (preview for view above!) -- !    *********
//struct BirdResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BirdResultsView(self.birds, $audioURL, self.loading)
//    }
//}
///
