//
//  SwiftUIView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/7/21.
//
/// ----------- Working on this ! -------------------------------------------------------------

import SwiftUI

struct ModalView2: View {
    
    /// ****** loading ball! - true because when it opens I want it there ******
    @State var isLoading: Bool = true
    @State var audioURL: URL
    /// ***** to close  modal view - this comes from Recording LIst *****
    /// changes when results view (***API  *** ends with completion handler) display
    @Binding var showResults: Bool

    var body: some View {
        VStack {
            if isLoading {
                /// ***** ADD ANOTHER VSTACK? ***8 OVERLAPPING!
                Text("Analyzing Audio")
                    .padding()
                Spacer()
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(7)
                Spacer()
                Spacer()
            } else {
                Button("Dismiss Results") {
                    self.showResults = false
                }
            }
            /// initializing  BirdResultsView with the audio url file
            BirdResultsView(audioURL: self.$audioURL, loading: self.$isLoading)
        } /// end Vstack

    } /// end body
} // end ModalView

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


///  ******  FIX ERRORS IN   -  Preview  ******
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
