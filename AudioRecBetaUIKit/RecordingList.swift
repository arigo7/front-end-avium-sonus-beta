//
//  RecordingList.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//

//Above the start/stop button, we will display the already created recordings in a list. Therefore, we create a new File-New-Swift file, select SwiftUI view and call it RecordingsList. Here, we insert an empty list. Later we will fill list with the already saved recordings. Here, we can also create an ObservedObject for the RecordingsList for the AudioRecorder, since we will need it later on.

import SwiftUI

struct RecordingList: View {
    //ObservedObject for the RecordingsList for the AudioRecorder (dependency)
    @ObservedObject var audioRecorder: AudioRecorder
    var body: some View {
        // Adding one RecordingView for each object in the recordings array of the audioRecorder.
//        Color(#colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.5960784314, alpha: 1))
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            // Last, apply delete functionality to every RecordingRow in the RecordingList
            .onDelete(perform: delete)
        }
    }
    
    /// Edit button implementation of delete function in RecordingsList
    /// OFFSETS argument represents a set of indexes of recording rows that the user has chosen to delete. With these, create array of file paths of tgBy recordings to be deleted
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        /// Call deleteRecording function delete function of our RecordingsList
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
        
    } /// end function delete
}

//RecordingsList should display one row per stored recording, therefore, adding RecordingRow View struc into RecordingsList struct.
struct RecordingRow: View {
    
    var audioURL: URL
    let api = Api()
    // Each RecordingRow needs its own AudioPlayer for the respective audio recording, so here initialize one separate AudioPlayer instance as an ObservedObject for each RecordingRow
    @ObservedObject var audioPlayer = AudioPlayer()
    
    ///-- flag for presenting  Modal
    @State var presentingModal = false
    @State var birds: [Bird] = []
    var body: some View {
        HStack {
            /// Moved Api call inside Modal View
            /// print(self.audioURL)
            Button(action: {
                /// we are saying present modal now with click as well
                /// w/ Button analyze AKA SPARKLES
                self.presentingModal = true
                        }) {
                            Image(systemName: "sparkles")
                                .imageScale(.large)
                                .foregroundColor(.orange)
                        }
                        .buttonStyle(PlainButtonStyle())
                        ///*******
                        /// prop audio url passed on here, modal is built with all args from modal view declaration
                        /// presentingModal is b
                        /// will present modal if isPresented is true which is bound to  presentingModal - if its true (is presented) and it creates a new modal view
                        .sheet(isPresented: self.$presentingModal) { ModalView2(audioURL: self.audioURL, showResults: self.$presentingModal) }
            
            /// Each row assigned their particular audio file's path. Within the HStack: file without extension  (Text object) pushed left with Spacer()'s help.
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            /// If audioPlayer not playing, display  play button to allow user to listen to  recording
            if audioPlayer.isPlaying == false {
                Button(action: {
                    /// call the two functions (startPlayback(audio) and stopPlayback()) from RecordingRow’s start and stop buttons
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                        .foregroundColor(.pink)
                }
                /// condition with play/sparkles buttons!
                .buttonStyle(PlainButtonStyle())
                
            /// Else, If  audio is currently playing,  display a button to stop  playback
            } else {
                Button(action: {
                    /// "stop playing audio
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                /// avoids raise condition with play/sparkles buttons!
                .buttonStyle(PlainButtonStyle())
            } /// end conditional statement
        } // end of Hstack
//        .background(Color.yellow.opacity(0.5))
        .background(Color(#colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.5960784314, alpha: 1)).opacity(0.75))

    } // end body
} // RecordingRow


struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}


/// BACK UP -----------------------------------------------------------------------------------------
////Above the start/stop button, we will display the already created recordings in a list. Therefore, we create a new File-New-Swift file, select SwiftUI view and call it RecordingsList. Here, we insert an empty list. Later we will fill list with the already saved recordings. Here, we can also create an ObservedObject for the RecordingsList for the AudioRecorder, since we will need it later on.
//
//import SwiftUI
//
//
//// THIS WAS NAMED RECORDINGssssssList in tutorial! not RecordingList so watch out!
//struct RecordingList: View {
//
//    //ObservedObject for the RecordingsList for the AudioRecorder (dependency)
//    @ObservedObject var audioRecorder: AudioRecorder
//
//    var body: some View {
//        // In our RecordingsList, we add one RecordingView for each object in the recordings array of the audioRecorder.
//        List {
////            Text("Empty list")
//            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
//                RecordingRow(audioURL: recording.fileURL)
//            }
//            // Finally, apply delete functionality to every RecordingRow in the RecordingList
//            .onDelete(perform: delete)
//        }
//    }
//
//    // Edit button implementation of delete function in RecordingsList
//    // OFFSETS argument represents a set of indexes of recording rows that the user has chosen to delete. With these, create array of file paths of tgBy recordings to be deleted
//    func delete(at offsets: IndexSet) {
//
//        var urlsToDelete = [URL]()
//        for index in offsets {
//            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
//        }
//        // Call deleteRecording function delete function of our RecordingsList
//        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
//
//    } // end function delete
//}
//
//struct ModalView: View {
//    @Binding var presentedAsModal: Bool
//    @State var audioURL: URL
//
//
//    var body: some View {
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


///RecordingsList should display one row per stored recording so we add a RecordingRow view struc RecordingsList struct.

//struct RecordingRow: View {
//
//    var audioURL: URL
//    let api = Api()
//
//    // Each RecordingRow needs its own AudioPlayer for the respective audio recording, so here initialize one separate AudioPlayer instance as an ObservedObject for each RecordingRow
//
//    @ObservedObject var audioPlayer = AudioPlayer()
//    @State var presentingModal = false  //-- for presenting flag for presenting modal -
//    @State var birds: [Bird] = []
//    var body: some View {
//        HStack {
//                        Button(action: {
//                        /// Api call here
////                      print("Analyzing Audio")
////                      print(self.audioURL)
//////
//                            self.presentingModal = true
//                            /// Button ANalyze AKA SPARKLES
//                            /// now call the two functions (startPlayback(audio) and stopPlayback()) from our RecordingRow’s start and stop buttons
//                        }) {
//                            Image(systemName: "sparkles")
//                                .imageScale(.large)
//            //                Text("Sent to Analyze")
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                        // prop audio url passed on here, modal is built with that url
//                        .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal,  audioURL: self.audioURL) }
//            // Each row should be assigned to the path of the particular audio file. Within the HStack we then path without the file extension for a Text object which we push to the left side with the help of a Spacer.
//            Text("\(audioURL.lastPathComponent)")
//            Spacer()
//
//            //If the audioPlayer is not playing, we want to display a play button that allows the user to listen to the recording
//
//            if audioPlayer.isPlaying == false {
//                Button(action: {
////                    // "Start playing audio"
////                    print("Play audio")
//                    // now call the two functions (startPlayback(audio) and stopPlayback()) from our RecordingRow’s start and stop buttons
//                    self.audioPlayer.startPlayback(audio: self.audioURL)
//                }) {
//                    Image(systemName: "play.circle")
//                        .imageScale(.large)
//                }
//                .buttonStyle(PlainButtonStyle())
//                // If an audio is currently playing, we need to display a button to stop the playback
//            } else {
//                Button(action: {
////                    // "stop playing audio
////                    print("Stop playing")
//                    self.audioPlayer.stopPlayback()
//                }) {
//                    Image(systemName: "stop.fill")
//                        .imageScale(.large)
//                }
//                .buttonStyle(PlainButtonStyle())
//            } // end of if and else  statement
//
//
//        } // end of Hstack
//
//
//    } // end of declaration of body
//} // end of struct RecordingRow
//
//
//struct RecordingList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingList(audioRecorder: AudioRecorder())
//    }
//}

