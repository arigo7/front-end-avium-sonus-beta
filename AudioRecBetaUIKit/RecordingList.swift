//
//  RecordingList.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//

//Above the start/stop button, we will display the already created recordings in a list. Therefore, we create a new File-New-Swift file, select SwiftUI view and call it RecordingsList. Here, we insert an empty list. Later we will fill list with the already saved recordings. Here, we can also create an ObservedObject for the RecordingsList for the AudioRecorder, since we will need it later on.

import SwiftUI

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
        }
    }
}

//RecordingsList should display one row per stored recording so we add a RecordingRow view struc RecordingsList struct.
struct RecordingRow: View {
    
    var audioURL: URL
    
    var body: some View {
        HStack {
            // Each row should be assigned to the path of the particular audio file. Within the HStack we then path without the file extension for a Text object which we push to the left side with the help of a Spacer.
            Text("\(audioURL.lastPathComponent)")
            Spacer()
        }
    }
}


struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
