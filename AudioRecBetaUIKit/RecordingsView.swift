//
//  ContentView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//
// ContentView.swift - by default SwiftUi declare ContentView and ContentView_Previws

/// Example of hat an audio file path  /Users/ada/Developer/projects/capstone/feAviumSonusBeta/AudioRecBetaUIKit/AudioRecBetaUIKit/com.arigo.AudioRecBetaUIKit 2021-08-06 00:21.45.xcappdata/AppData/Documents/06-08-21_at_00:06:06.m4a

import SwiftUI
import CoreLocation

/// Content view will need to access an AudioRecorder instance - need to declare ObsevedObject on AudioRecorder

struct RecordingsView: View {
    
    /// declaring audioRecorder as ObservedObject
    @ObservedObject var audioRecorder: AudioRecorder
    var body: some View {
        
        /// ContentView embeded in a NavigationView and provide it with a navigation bar.
        NavigationView{
            
            VStack {
                
                /// Inserting RecordingsList into ContentView above the start/stop button => using an
                /// AudioRecorder instance of the ContentView as the RecordingsList‘s audioRecorder.
                RecordingList(audioRecorder: audioRecorder)
                
                /// when audioRecorder not recording presents a button to start recording
                if audioRecorder.recording == false {
                    
                    /// Recording button a pink circle!
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
                /// if audioRecorder is not recording - button to stop recording
                } else {
                    
                    
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
            .navigationBarTitle("Bird Sound Recorder")
            // to allow user to delete each recording, add default edit button  the navigation bar of ContentView
            // button enables the user to select individual RecordingRows from the RecordingList to delete. To do this, the Edit button expects us to implement a delete function. We have to add this function to our RecordingsList.
            .navigationBarItems(trailing: EditButton())
//            .navigationBarItems(trailing: )   //// Here I have to implement button to select item and send it over!
            
        } // end of navigationView 
        
    }
}

struct RecordingsView_Previews: PreviewProvider {
    static var previews: some View {
        /// initializing and Audio recorder instance on previous struct, as well as for the scene function on our scenedelegate.swift ContentView
        RecordingsView(audioRecorder: AudioRecorder())
    }
}
