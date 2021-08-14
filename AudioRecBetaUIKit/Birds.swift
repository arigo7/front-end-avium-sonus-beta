//
//  Birds.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.

/// Birds Model

import Foundation

struct Bird: Codable, Identifiable {
    let id = UUID()
    var view: String
    var channel: String
    var beginFile: String
    var beginTimeSec: Int
    var endTimeSec: Int
    var lowFreqHz: String
    var highFreqHz: String
    var speciesCode: String
    var commonName: String
//    var confidence: String
    var confidence: Double
    var rank: String
}


