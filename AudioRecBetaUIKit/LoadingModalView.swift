//
//  SwiftUIView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/7/21.
//

import SwiftUI
struct ModalView2: View {
    
    /// ****** loading ball! - true - when it opens I want it there ******
    @State var isLoading: Bool = true
    @State var audioURL: URL
    
    /// ***** to close  modal view - (from Recording LIst)*****
    /// changes when ResultsView (**API ** ends with completion handler) display
    @Binding var showResults: Bool

    var body: some View {
        
//        VStack (spacing: 55){
        VStack (spacing: 10){
            
            if isLoading {
                
                VStack (spacing: 10) {
                    Spacer()
                    Button("Dismiss Analysis") {
                        self.showResults = false
                    }
                    .foregroundColor(.pink)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                    .font(Font.footnote.weight(.bold))
                    
                }
                 Text("Analyzing Audio")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
//                    .padding()
                Text("with BirdNET ")
                    .foregroundColor(.black)
                    .font(.title3)
//                    .fontWeight(.bold)
                
                Spacer()
                Spacer()
                /// Image waves, bird NO PREVIEW ;(
                ZStack {
                    Image("AvSonWaves").padding([.leading, .bottom], 20.0).frame(width: 100/*@END_MENU_TOKEN@*/, height: 100/*@END_MENU_TOKEN@*/, alignment: .bottomLeading).opacity(0.6)
                    Spacer()
                    Image("AviumSonusBird").padding([.top, .leading]).frame(alignment: .topTrailing).opacity(0.8)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(15)
                    .padding(150)
                Spacer()
                Spacer()
                }
                
            } else {
//                VStack (spacing: 10){
                VStack {
                    Button("Dismiss Results") {
                        
                        self.showResults = false
                    }
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                    
                }
//                Button("Dismiss Results") {
//
//                    self.showResults = false
//                }
//                .foregroundColor(.gray)
            }
            /// initializing  BirdResultsView with the audio url file
            BirdResultsView(audioURL: self.$audioURL, loading: self.$isLoading)
        } /// end Vstack

    } /// end body
} // end ModalView


/// -----------------------------------------------------
//
////

//struct ModalView2_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ModalView2(audioURL: self.audioURL, showResults: self.$presentingModal)
//
//
//    }
//}
//


//-------------------------------------------------------

/// HOW IT WAS SO IT DOESN'T GIVE ME ERRORS
//
//struct ModalView: View {
//    @Binding var presentedAsModal: Bool
//    var body: some View {
//
//        //  check file updates - every whatever time
//
//        Button("dismiss") { self.presentedAsModal = false }
//    }
//}

///  ******  FIX ERRORS IN   -  Preview  ******
/// -----------------------------------------------------
//
////

//.preferredColorScheme(.dark)


///  ******  BACK UP  - starts here ****** --------------------------------------------------------------------------------
//import SwiftUI

//struct SwiftUIView: View {
//
//    var body: some View {
//        Text("Intermediate / Modal View")
//    }
//}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}

// -------------------------------------------------------------
//  WOrking on this === I"M HERE!!!     BACK UP, this was here

///  changed to ModalView

//struct ModalView: View {
//    @Binding var presentedAsModal: Bool
//    @State var audioURL: URL
//
//
//    var body: some View {
//
//        Button("Dismiss Results") { self.presentedAsModal = false }
////        VStack(alignment: .center) {
//        //    Text("Analyzing audio ...")
//        //        .opacity(0.90)
//        //        .foregroundColor(.pink)
//        //    ProgressView()
//        //        .progressViewStyle(CircularProgressViewStyle())
//        //}
//        // initializing the birds results view with the audio url file
//        BirdResultsView(audioURL: self.$audioURL)
//    } // end body modal
//} // end modal view
//

//-------------------------------------------------------

/// HOW IT WAS SO IT DOESN'T GIVE ME ERRORS

// struct ModalView: View {
//@Binding var presentedAsModal: Bool
//var body: some View {
//
////  check file updates - every whatever time
//
//    Button("dismiss") { self.presentedAsModal = false }
//}

/// end of BACK UP!

/// -----------------------------------------------------
//
////

//struct ModalView2_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ModalView2(audioURL: self.audioURL, showResults: self.$presentingModal)
//
//
//    }
//}
//
