//
//  RecordingDataModel.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/6/21.
//

import Foundation

struct Recording {
    let fileURL: URL
    /// To give the recording a unique namee, createdAt will be the name  of recording that will be the date/time it was created
    let createdAt: Date
}
