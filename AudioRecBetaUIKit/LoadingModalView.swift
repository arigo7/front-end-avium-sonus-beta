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
                    Button("Cancel") {
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
                    Image("AvSonWaves")
                        .padding([.leading, .bottom], 20.0)
                        .frame(width: 100/*@END_MENU_TOKEN@*/, height: 100/*@END_MENU_TOKEN@*/, alignment: .bottomLeading)
                        .opacity(0.6)
                    Spacer()
                    Image("AviumSonusBird")
                        .padding([.top, .leading])
                        .frame(alignment: .topTrailing)
                        .opacity(0.8)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(7)
                    .padding(150)
                Spacer()
                Spacer()
                }
                
            } else {
//                VStack (spacing: 10){
                VStack {
                    Button("Dismiss") {
                        
                        self.showResults = false
                    }
                    .foregroundColor(.pink)
                    .padding(.top, 10)
                    .font(Font.footnote.weight(.bold))
                    
                }
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

