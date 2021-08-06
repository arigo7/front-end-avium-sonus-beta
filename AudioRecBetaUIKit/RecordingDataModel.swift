//
//  RecordingDataModel.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/6/21.
//

import Foundation

struct Recording {
    let fileURL: URL
    // Don't really want it to be a Date, but if it doesn't affect back end, it's all good
    let createdAt: Date
}
