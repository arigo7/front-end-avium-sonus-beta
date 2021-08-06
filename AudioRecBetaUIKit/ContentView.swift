//
//  ContentView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//
// /Users/ada/Developer/projects/capstone/feAviumSonusBeta/AudioRecBetaUIKit/AudioRecBetaUIKit/com.arigo.AudioRecBetaUIKit 2021-08-06 00:21.45.xcappdata/AppData/Documents/06-08-21_at_00:06:06.m4a

import SwiftUI

// Content view will need to access an Audio Recorder instance so we declare a corresponding ObsevedObbject
struct ContentView: View {
    // declaring corresponding ObservedObject
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        // We embed our ContentView in a NavigationView and provide it with a navigation bar.
        // NAVIGATION!!!!!! 
        NavigationView{
            VStack {
                // Inserts the RecordingsList into our ContentView above the start/stop button and uses the AudioRecorder instance of the ContentView as the RecordingsList‘s audioRecorder.
                RecordingList(audioRecorder: audioRecorder)
                if audioRecorder.recording == false {
                    // or Button(action: {self.audioRecorder.stopRecording()}) { ???
                    // Button(action: {print("Record")}) { to:
                    Button(action: {self.audioRecorder.startRecording()}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            //can add alignment:center here, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/ too
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .clipped()
                            .foregroundColor(.pink)
                            .padding(.bottom, 40)
                    }
                    
                } else {
                    // Button(action: {print("Stop")}) { now:
                    //call stopRecording() function from our stop button:
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .clipped()
                            .foregroundColor(.yellow)
                            .padding(.bottom, 40)
                    }
                }
                
            }
            .navigationBarTitle("Sound Recorder")
            
        } // end of navigationView 
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // initializing and Audio recorder instance for our previous struct, as well as for the scene function on our scenedelegate.swift ContentView
        ContentView(audioRecorder: AudioRecorder())
    }
}
