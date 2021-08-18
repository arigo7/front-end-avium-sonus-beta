//
//  AudioPlayer.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/6/21.
//
/// AudioPlayer structure  is very similar to the AudioRecorder structure
/// We implement the functions for playing and stopping the audio in our AudioPlayer, which we will call from the buttons of the RecordingRows.

import Foundation
import SwiftUI
import Combine
import AVFoundation

/// Implemented playback function and sound plays on speakers. To make stop button stop displaying although an audio was played to the end, update isPlaying variable accordingly
/// implement audioDidFinishPlaying function - which notifies when an audio has finished playing (part of the AVAudioPlayerDelegate protocol) Hint: To adapt this delegate protocol, the AudioRecorder must also adapt the NSObject protocol.
class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    /// PassthroughObject to notify observing views about changes, especially if an audio is being played or not
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    ///  var isPlaying  set to false by default. if value of isPlaying changes, we inform observing views using  objectWillChange property
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    } /// end isPlaying
    
    /// for playback functionality, we need an AVAudioPlayer instance from the AVFoundation framework
    var audioPlayer: AVAudioPlayer!
    
    /// adding a function startPlayback: function should accepts a URL, i.e. a file path for the audio to be played
    func startPlayback (audio: URL) {
        
        /// Like the in the recordingSession we start initializing a playbackSession inside this function.
        let playbackSession = AVAudioSession.sharedInstance()
        
        /// Default - sounds play through device’s earpiece. To play audio  through the loudspeaker, we have overwrite the output audio port accordingly
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over device's spekers failed")
        }
        
        /// We can start playing the audio with the help of the given file path and inform the observing views about this. If this does not work, we will output a corresponding error.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            
            /// When audio is played, set the AudioPlayer itself as the delegate of the AVAudioPlayer
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Oops, playback failed")
        }
    } /// startPlayback end
    
    /// function in AudioPlayer to stop the playback
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    } /// end of stopPlayback
    
    /// audioDidFinishPlaying function to AudioPlayer, if audio successfully plays, we set the playing properties value back to false
    /// When app runs now and play a recording, AudioPlayer calls the audioDidFinishPlaying function as its own delegate after the audio has been finished playing.
    /// This causes the playing attribute to be false again, which will eventually cause the particular RecordingRow to update itself and display the play button again.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    } /// audioPlayerDidFInishPlayin end
} /// end of class Audio Player declaration


