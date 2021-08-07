//
//  AudioRecorder.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//

// I think files will be saved here eventually? /Users/ada/Developer/projects/capstone/feAviumSonusBeta/AudioRecBetaUIKit/AudioRecBetaUIKit/Info.plist
// here I will need to insert location as well as send upload recording button

// we use our AudioRecorder to record, end and save audios



import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    
    // fetchRecordings function should be called every time a new recording is completed.
    // also when the app and therefore also the AudioRecorder is launched for the first time.
    // we overwrite the init function of the AudioRecorder accordingly. To make this work,
    //our AudioRecorder must adopt the NSObject protocol (above)
    override init() {
        super.init()
        fetchRecordings()
    }
    
    //To notify observing views about changes, for example when the recording is
    //started, we need a PassthroughObject.
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    // initialize an AVAudioRecorder instance with our AudioRecorder - this will
    // help start recording sessions later
    var audioRecorder: AVAudioRecorder!
    
    // after creating RecordingDataModel, create array to hold the recordings.
    var recordings = [Recording]()
    
    // audio Rec should pay attention  if it's alrady recording. If this variable
    // is changed when recording is  finished, we update subscribing views using
    // objectWillChange property
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    // Implements function to start audio recording when user taps on the record button. We call this function startRecording.
    func startRecording() {
        // creates a recording session
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        //specifies location where recording should be saved
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // file is named after the date and time of the recording and has .m4a format
        // Could change the name to something
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")

        // define settings for our recording
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        //star recording with our audioRecorder property! Then we inform our ContentView that the recording is running so that it can update itself and display the stop button instead of the start button.
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Oops, couldn't start recording")
        }
    } // end of startRecording function declaration
    
    // implement function to end the recording which stops recording session of our AudioRecorder and informs all observing views about this by setting the recording variable to false again.
    func stopRecording() {
        audioRecorder.stop()
        recording = false
        
        //fetchRecordings function should be called every time a new recording is completed
        fetchRecordings()
        
    } //end of stopRecording function
    
    //implement a function called fetchRecordings to access the stored recordings
    func fetchRecordings() {
        
        //Every time we fetch recordings we have to empty our recordings array before, this avoids recordings being displayed multiple times.
        recordings.removeAll()
        
        //Then we access the documents folder where the audio files are located and cycle through all of them
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            // uses getCreationDate function created for the respective audio recording. We then create one Recording instance
            // per audio file and add it to our recordings array.
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
            
        }
        // sort the recordings array by the creation date of its items and
        // eventually update all observing views, especially RecordingsList
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        objectWillChange.send(self)
        
    } // end fetchRecordings func
    
    func deleteRecording(urlsToDelete: [URL]) {
        
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
                
            } catch {
                print("File couln't be deleted!")
            }
        }// end of for loop
        
        fetchRecordings()
        
    } // end deleteRecording func
    
} // end of class declaration?
