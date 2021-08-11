//
//  RecordingList.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//

//Above the start/stop button, we will display the already created recordings in a list. Therefore, we create a new File-New-Swift file, select SwiftUI view and call it RecordingsList. Here, we insert an empty list. Later we will fill list with the already saved recordings. Here, we can also create an ObservedObject for the RecordingsList for the AudioRecorder, since we will need it later on.

import SwiftUI


// THIS WAS NAMED RECORDINGssssssList in tutorial! not RecordingList so watch out!
struct RecordingList: View {
    
    //ObservedObject for the RecordingsList for the AudioRecorder
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        // In our RecordingsList, we add one RecordingView for each object in the recordings array of the audioRecorder.
        List {
//            Text("Empty list")
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            // Finally, apply delete functionality to every RecordingRow in the RecordingList
            .onDelete(perform: delete)
        }
    }
    
    // Edit button implementation of delete function in RecordingsList
    // OFFSETS argument represents a set of indexes of recording rows that the user has chosen to delete. With these, create array of file paths of tgBy recordings to be deleted
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        // Call deleteRecording function delete function of our RecordingsList
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
        
    } // end function delete
}

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @State var audioURL: URL
    
    
    var body: some View {
        Button("Dismiss Results") { self.presentedAsModal = false }
//        VStack(alignment: .center) {
        //    Text("Analyzing audio ...")
        //        .opacity(0.90)
        //        .foregroundColor(.pink)
        //    ProgressView()
        //        .progressViewStyle(CircularProgressViewStyle())
        //}
        // initializing the birds results view with the audio url file
        BirdResultsView(audioURL: self.$audioURL)
    } // end body modal
} // end modal view

/// if self.presentedAsModal {
//VStack(alignment: .center) {
//    Text("Analyzing audio ...")
//        .opacity(0.90)
//        .foregroundColor(.pink)
//    ProgressView()
//        .progressViewStyle(CircularProgressViewStyle())
//}
//} else {
//// initializing the birds results view with the audio url file
//BirdResultsView(audioURL: self.$audioURL)
//}

//RecordingsList should display one row per stored recording so we add a RecordingRow view struc RecordingsList struct.
struct RecordingRow: View {
    
    var audioURL: URL
    let api = Api()
    
    // Each RecordingRow needs its own AudioPlayer for the respective audio recording, so here initialize one separate AudioPlayer instance as an ObservedObject for each RecordingRow
    
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var presentingModal = false  //-- for presenting flag for presenting modal -
    @State var birds: [Bird] = []
    var body: some View {
        HStack {
            // Button ANalyze
                        Button(action: {
//                                // Api call here
//                                print("Analyzing Audio")
//                            print(self.audioURL)
////                            Api().uploadData(audioFile: self.audioURL)
//                            api.uploadData(audioFile: self.audioURL)
                            self.presentingModal = true
                            // now call the two functions (startPlayback(audio) and stopPlayback()) from our RecordingRow’s start and stop buttons
            //                self.audioPlayer.startPlayback(audio: self.audioURL)
                        }) {
                            Image(systemName: "sparkles")
                                .imageScale(.large)
            //                Text("Sent to Analyze")
                        }
                        // prop audio url passed on here, modal is built with that url
                        .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal,  audioURL: self.audioURL) }
            // Each row should be assigned to the path of the particular audio file. Within the HStack we then path without the file extension for a Text object which we push to the left side with the help of a Spacer.
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            
            //If the audioPlayer is not playing, we want to display a play button that allows the user to listen to the recording
           
            // THIS IS STEP NUMBER 2 I THINK
            
//            // BUTTON ANALYZE
//            Button(action: {
//                Api().uploadData(audioFile: Data, completion: <#T##([Bird]) -> ()#>)
//            }, label: {
//                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//            })
//            .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal) }
//            Button(action: Api(), label: <#T##() -> _#>)
            
//
            
            
            
            
//            
            if audioPlayer.isPlaying == false {
                Button(action: {
//                    // "Start playing audio"
//                    print("Play audio")
                    // now call the two functions (startPlayback(audio) and stopPlayback()) from our RecordingRow’s start and stop buttons
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
                // If an audio is currently playing, we need to display a button to stop the playback
            } else {
                Button(action: {
//                    // "stop playing audio
//                    print("Stop playing")
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            } // end of if and else  statement
            
            
        } // end of Hstack
        
        
    } // end of declaration of body
} // end of struct RecordingRow


struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
