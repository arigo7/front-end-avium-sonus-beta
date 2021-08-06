//
//  AudioPlayer.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/6/21.
//
// The structure of our AudioPlayer is very similar to the AudioRecorder

// We implement the functions for playing and stopping the audio in our AudioPlayer, which we will call from the buttons of the RecordingRows.

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: ObservableObject {
    //PassthroughObject to notify observing views about changes, especially if an audio is being played or not
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    // implement var isPlaying and set to false by default.
    // if value of isPlaying changes, we inform observing views using our objectWillChange property
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    } // end of isPlaying declaration
    
    //for playback functionality, we need an AVAudioPlayer instance from the AVFoundation framework
    var audioPlayer: AVAudioPlayer!
    
    // adding a function startPlayback: function should accepts a URL, i.e. a file path for the audio to be played
    func startPlayback (audio: URL) {
        
        // Like the in the recordingSession we start initializing a playbackSession inside this function.
        let playbackSession = AVAudioSession.sharedInstance()
        
        //By default, sounds play through device’s earpiece, for audio to be played through the loudspeaker, we have overwrite the output audio port accordingly
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing on device's spekers failed")
        }
        
        // We can start playing the audio with the help of the given file path and inform the observing views about this. If this does not work, we will output a corresponding error.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Oops, playback failed")
        }
    }
    
    // function in AudioPlayer to stop the playback 
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    
} // end of class Audio Player declaration


