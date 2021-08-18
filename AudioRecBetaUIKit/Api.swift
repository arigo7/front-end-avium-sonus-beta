//
//  Api.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/7/21.
//

// ObservableObject (protocol ∈ Combine framework) used within custom class/model
// (Bird is a Model) - keeps track of state used with some sort of class that can store data

import Foundation
import Alamofire
import CoreLocation
import SwiftLocation
// import Combine? 

class Api: ObservableObject {
    
    /// @Published before a property - will update any SwiftUI views that are watching for changes (lets swift know to watch for changes of this variable)
    @Published var birds = [Bird]();
    // timeout default is is less than I need
    var sessionManager: Alamofire.Session?;
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    /// initializing an alamofire session instance
    init() {
        let configuration = URLSessionConfiguration.af.default;
        
        /// flask response takes from 45 sec -1 min - so it doesn't time out before this time
        // here it's finished uploading but because of setup I don't have an indicator of when it's analyzing and it's finished uploading
        // so hard coding time to greater than a min to wait for results, in case of too many resources being used (ie. zoom)
        configuration.timeoutIntervalForRequest = 500;
        
        /// Alamofire instance
        sessionManager = Alamofire.Session(configuration: configuration, startRequestsImmediately: true);
    }
    
    /// GET  request (JSON FILE TEST)
    func loadData(completion:@escaping ([Bird]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:5000/jsonfile") else {
            print("Invalid url...")
            return
        }
        
        /// URLSession (class) -  API for downloading and uploading data from and to endpoints indicated by URLs (app creates one or more URLSession instances - each coordinating a group of related data-transfer tasks).
        ///
        /// ****** URLSession has singleton shared session for basic requests ****** WHAT THE HECK IS SINGLETON?
        ///
        /// Within a session, it create tasks that optionally upload data to a server and then retrieve data from the server either as a file on disk or as one or more NSData objects in memory. Data tasks send and receive data using NSData objects.
        ///
        /// dataTask(with:completionHandler:) - creates task -
        /// completion handler within dataTask - 1: retreives URL contents based on specified URL request object, 2: calls handler upon completion (with: url) - URL request object
        /// { data, response, error ....  - completionHandler
        ///  data: data returned by the server
        /// response: object with response metadata (headers, status code)
        /// error: object indicating why request failed or nil if req was successful
        
        /// completion handler
        URLSession.shared.dataTask(with: url) {data, response, error in
            /// put data into  Bird model
            let birds = try! JSONDecoder().decode([Bird].self, from: data!)
            print(birds)
            
            /// Reload the  view using the main dispatch queue
            DispatchQueue.main.async {
                completion(birds)
            }
            /// After creating the task, it needs to be started - by calling its resume() method.
            /// end of completion handler
        }.resume()
    } /// end loadData
    
    
    /// POST method with  embeded audio file
    /// upload data takes in an audio file and a function (completion @ escaping - won't do garbage collection to the function)  -
    func uploadData(audioFile: URL, completion:@escaping ([Bird]) -> ()) {
        
        // To get lat, lon with SwiftLocation
        SwiftLocation.gpsLocation().then {
            self.latitude = $0.location!.coordinate.latitude
            self.longitude = $0.location!.coordinate.longitude
            
            // checking it works!
            debugPrint("Location is \(self.latitude!), \(self.longitude!)")
            
            // putting results into my Bird model
            struct HTTPBinResponse: Decodable {let results: [Bird]}
            
            // audio file -- read file
            let data: Data? = try? Data(contentsOf: audioFile)
            
            // passing on lat / lon through headers to B-end
            var headers: HTTPHeaders = HTTPHeaders.default
            
            // lat / lon values
            headers.add(HTTPHeader(name: "latitude", value: "\(self.latitude!)"))
            headers.add(HTTPHeader(name: "longitude", value: "\(self.longitude!)"))
            
            // api call - upload with AF
            (self.sessionManager)!.upload(data!, to: "http://127.0.0.1:5000/bird_stream", headers: headers).responseJSON {
                response in
                debugPrint(response)
                /// data otherwise if  is  null - return
                guard let data = response.data else { return }
                
                /// if this birds is empty display
                let birds = try! JSONDecoder().decode([Bird].self, from: data)
                
                ///  Reload the  view using the main dispatch queue - (DispatchQueue concluye la llamada asincrona de completion(birds)  which happens in birdResults when calls the callback (completion(birds))
                DispatchQueue.main.async {
                    completion(birds)
                } /// DispatchQueue end - manages the execution of tasks serially or concurrently on the main thread or on a background thread
            }
        }
    }
    
}
