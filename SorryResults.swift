//
//  SorryResults.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/18/21.
//

import SwiftUI

struct SorryResults: View {
    var body: some View {
        VStack (alignment: .center, spacing: 5){
            //                Spacer()
            Text("Oops!")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            
            Text("BirdNET can't recognize the sound")
                .foregroundColor(.black)
                .font(.title3)
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
                .padding()
       
            /// *** INSERT 404 IMAGE with this! ***- Cannot recognize sound with certainty
            Image("SorryResults")
                .resizable()
                .frame(width: 350, height: 350, alignment: .center)
                .padding(.bottom, 10)
                .opacity(0.99)
//                Spacer()
//                Spacer()
            
            
//                HStack {
//                    Text("Hint:")
//                        .font(.system(size: 15))
//                        .lineLimit(nil)
//                        .foregroundColor(.black)
//
//                    Image("SorryResults")
//                        .resizable()
//                        .scaledToFit()
//                        .edgesIgnoringSafeArea(.all)
//                        .opacity(0.9)
//                }
//                .padding(.bottom, 30)
//                Spacer()
//                Image("SorryResults")
////                    .frame(maxWidth: 15, maxHeight: 15, alignment: .center)
//                    .resizable()
//                    .scaledToFit()
////                    .edgesIgnoringSafeArea(.all)
//                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
//                    .padding(.top, 10)
//                    .padding(.bottom, 30)
//            HStack {
//                Image("SorryResults")
//                    .resizable()
//                    .frame(maxWidth: 200, maxHeight: 200, alignment: .trailing)
////                    .edgesIgnoringSafeArea(.all)
//                    .opacity(0.9)
//                    .padding(.bottom, 10)
//            }
            Spacer()
            Spacer()
        
        } /// SORRY results- Vstack end
        .background(Color(#colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.5960784314, alpha: 1))).opacity(0.5)
    }
}

struct SorryResults_Previews: PreviewProvider {
    static var previews: some View {
        SorryResults()
    }
}
