//
//  Birds.swift
//  feAviumSonusBeta
//
//  Created by Ari on 8/5/21.
//

import Foundation

// EXAMPLE TO PARSE JSON TO INT
//let string = #"{"name": "watashi", "number": 42, "pi": 3.141592, "array": [2, 3, 5, 7, 11, 13]}"#
//
//let data = string.data(using: .utf8)!
//let object = try! JSONSerialization.jsonObject(with: data, options: [])
//
//let jsonObject = object as! [String: Any]
//
//let nameField   = jsonObject["name"]    as? String
//let numberField = jsonObject["number"]  as? Int
//let piField     = jsonObject["pi"]      as? Double
//let arrayField  = jsonObject["array"]   as? [Any]
//
//print("The name argument is \(nameField)")
//print("The number is \(numberField)")
//print("The value of pi is \(piField)")
//print("the array value is \(arrayField)")

struct Bird: Codable, Identifiable {
    let id = UUID()
    var view: String
    var channel: String
    var beginFile: String
    var beginTimeSec: String
    var endTimeSec: String
    var lowFreqHz: String
    var highFreqHz: String
    var speciesCode: String
    var commonName: String
    var confidence: String
    var rank: String
}
// ObservableObject (protocol ∈ Combine framework) used within custom class/model (Bird is a Model) -keeps track of state used with some sort of class that can store data
// @ObservedObject (protocol) - will be used (not here) inside a view to store an observable object instance and (inside?) the @Published property - before any properties that should trigger change notifications

