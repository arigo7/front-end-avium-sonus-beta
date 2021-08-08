//
//  Api.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/7/21.
//

import Foundation

class Api: ObservableObject {
    // @Published before a property - will update any SwiftUI views that are watching for changes (lets swift know to watch for changes of this variable)
    @Published var birds = [Bird]()

    func loadData(completion:@escaping ([Bird]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:5000/jsonfile") else {
            print("Invalid url...")
            return
        }
        // URLSession class - provide an API for downloading data from an uploading data to endpoints indicated by URLs (app creates one or more URLSession instances - each coordinating a group of related data-transfer tasks).
            //URLSession has singleton shared session for basic requests
        // Within a session, you create tasks that optionally upload data to a server and then retrieve data from the server either as a file on disk or as one or more NSData objects in memory. Data tasks send and receive data using NSData objects.
        //dataTask(with:completionHandler:) - creates task - 1 retreives URL contents based on specified URL req object, 2 calls handler upon completion
        //(with: url) - URL request object
        //{ data, response, error ....  - completionHandler
        // data: data returned by the server
        // response: object with response metadata (headers, status code)
        //error: object indicating why request failed or nil if req was successful
        
        // completion handler
        URLSession.shared.dataTask(with: url) {data, response, error in
            let birds = try! JSONDecoder().decode([Bird].self, from: data!)
            print(birds)
            DispatchQueue.main.async {
                completion(birds)
            }
        //After you create the task, you must start it by calling its resume() method.
        }.resume()
        
        
        
    }
    
    // THIS GOES ALONG WITH STEP NUMBER 2
    
    // method that checks check update
    // returns that file has changed like true false , endpoint in flask
    // true or false so check that new endpoint
    // load data 
    
//    func uploadData(audioFile: Data, completion:@escaping ([Bird]) -> ()) {
//    guard let url = URL(string: "http://127.0.0.1:5000/bird") else {
//        print("Invalid url...")
//        return
//        }
    // embed audio file
        // URLSession.shared.(pass in audio file) (upload the bird audio file)
        // once i up;load it';ll have completion handler { like ... data, response error  and inside comletion handler,
        // here it's finished uploading but because of setup I don't have an indicator of when it's analyzing
        // first hard code time a minute to wait for it because don't have indicator
        // method that checks if file has changed ( check update method)
       // call load data function = it'll pull whatever it has
//    }
}
