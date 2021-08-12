//
//  SwiftUIView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/7/21.
//

import SwiftUI

struct SwiftUIView: View {

    var body: some View {
        Text("Intermediate / Modal View")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

// -------------------------------------------------------------

//struct ModalView2: View {
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


/// -----------------------------------------------------

//
//// struct ModalView: View {
//@Binding var presentedAsModal: Bool
//var body: some View {
//
////  check file updates - every whatever time
//
//    Button("dismiss") { self.presentedAsModal = false }
//}

