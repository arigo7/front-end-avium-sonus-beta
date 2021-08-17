//
//  ContentView.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//
// ContentView.swift - by default SwiftUi declare ContentView and ContentView_Previws

/// audio file path name example: /Users/ada/Developer/projects/capstone/feAviumSonusBeta/AudioRecBetaUIKit/AudioRecBetaUIKit/com.arigo.AudioRecBetaUIKit 2021-08-06 00:21.45.xcappdata/AppData/Documents/06-08-21_at_00:06:06.m4a

import SwiftUI
import CoreLocation

///  RecordingsView will need to access an AudioRecorder instance - need to declare ObsevedObject on AudioRecorder

struct RecordingsView: View {
    /// declaring audioRecorder as ObservedObject
    @ObservedObject var audioRecorder: AudioRecorder
    var body: some View {
        /// RecordingsView (ContentView) embeded in a NavigationView and provide it with a navigation bar.
        
        NavigationView{
            VStack {
                /// Inserting RecordingList into RecordingsView above  record/stop button => using an AudioRecorder instance of the ContentView as the RecordingsList‘s audioRecorder.
                RecordingList(audioRecorder: audioRecorder)
                /// when audioRecorder not recording presents a button to start recording
                if audioRecorder.recording == false {
                    /// **** MAKE PRETTY IF TIME ALLOWS ***
                    Button(action: {self.audioRecorder.startRecording()}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            //can add alignment:center here, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/ too
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .clipped()
                            /// Recording button a pink circle!
                            .foregroundColor(.pink)
                            .padding(10) /// top and bottom
                        //                            .padding(.bottom, 40) /// bottom only
                    } /// end button formatting for start recording
                    /// if audioRecorder is not recording - button to stop recording
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .clipped()
                            .foregroundColor(.yellow)
                            .padding(10)
                        //                            .padding(.bottom, 40)
                        //                            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    } /// end of button formatting for stop recording
                } /// end conditional
            } /// end Vstack
            .navigationTitle("Bird Sound Recorder")
            //            .navigationBarTitle("Bird Sound Recorder")
            //            .accentColor(Color("AccentColor"))
            /// changes recordings color
            //            .foregroundColor(.gray)
            
            /// Add default edit button on  navigation bar  -  allows user to delete each recording. Edit button enables  user to select individual RecordingRows from  RecordingList and delete. For this, edit button expects implementation of a delete function. We have to add this function to our RecordingsList.
            .navigationBarItems(trailing: EditButton())
            
        } /// NavigationView end
        
        .accentColor(.pink)  // edit button
    } /// body end
} /// RecordingsView end


struct RecordingsView_Previews: PreviewProvider {
    /// *** Aug-16 ***
    @ObservedObject var audioRecorder: AudioRecorder
    static var previews: some View {
        /// initializing and Audio recorder instance on previous struct, as well as for the scene function on our scenedelegate.swift ContentView
        RecordingsView(audioRecorder: AudioRecorder())
        //            .preferredColorScheme(.dark)
        //            .preferredColorScheme(.light)
        
        
    }
}
