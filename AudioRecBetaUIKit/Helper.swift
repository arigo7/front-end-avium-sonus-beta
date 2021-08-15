//
//  Helper.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/6/21.
//

/// In addition to the file path of the recording, to know when it was created.

import Foundation
/// Helper function: reads out the file at the given path and returns the date when it was created.
/// If this fails, we simply return the current date.
func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
       let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
