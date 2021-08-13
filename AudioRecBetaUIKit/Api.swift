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
    // @Published before a property - will update any SwiftUI views that are watching for changes (lets swift know to watch for changes of this variable)
    
    @Published var birds = [Bird]();
    var sessionManager: Alamofire.Session?;
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    // initializing an alamofire session instance
    init() {
        let configuration = URLSessionConfiguration.af.default;
        
        // flask response takes from 45 sec -1 min - so it doesn't time out before this time
        configuration.timeoutIntervalForRequest = 180;
        
        // Alamofire instance
        sessionManager = Alamofire.Session(configuration: configuration, startRequestsImmediately: true);
    }

    func loadData(completion:@escaping ([Bird]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:5000/jsonfile") else {
            print("Invalid url...")
            return
        }
        // URLSession class -  API for downloading and uploading data from and to endpoints
        // indicated by URLs (app creates one or more URLSession instances - each coordinating
        // a group of related data-transfer tasks).
        // URLSession has singleton shared session for basic requests
        // Within a session, you create tasks that optionally upload data to a server and then
        // retrieve data from the server either as a file on disk or as one or more NSData objects
        // in memory. Data tasks send and receive data using NSData objects.
        // dataTask(with:completionHandler:) - creates task - 1 retreives URL contents based
        // on specified URL req object, 2 calls handler upon completion
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
    } // end loadData
    

    
    

    // embed audio file
        // URLSession.shared.(pass in audio file) (upload the bird audio file)
        // once I upload it, I'll have completion handler { like ... data, response, error
        // and inside comletion handler,
        // here it's finished uploading but because of setup I don't have an indicator of when it's analyzing
        // first hard code time a minute to wait for it because don't have indicator
        // method that checks if file has changed ( check update method)
       // call load data function = it'll pull whatever it has
//    }
    

        func uploadData(audioFile: URL, completion:@escaping ([Bird]) -> ()) {

            SwiftLocation.gpsLocation().then {
                self.latitude = $0.location!.coordinate.latitude
                self.longitude = $0.location!.coordinate.longitude
                debugPrint("Location is \(self.latitude!), \(self.longitude!)")
            
                struct HTTPBinResponse: Decodable {let results: [Bird]}
                let data: Data? = try? Data(contentsOf: audioFile)
                
                var headers: HTTPHeaders = HTTPHeaders.default
                headers.add(HTTPHeader(name: "latitude", value: "\(self.latitude!)"))
                headers.add(HTTPHeader(name: "longitude", value: "\(self.longitude!)"))
                (self.sessionManager)!.upload(data!, to: "http://127.0.0.1:5000/bird_stream", headers: headers).responseJSON {
                    response in
                    debugPrint(response)
                    guard let data = response.data else { return }
                    
                    /// if this birds is empty display
                    let birds = try! JSONDecoder().decode([Bird].self, from: data)
                    /// Reload the  view using the main dispatch queue
                    DispatchQueue.main.async {
                        completion(birds)
                        /// loading false
                        
                    // else the no results found on screen, on the catch I can use 400 response
                    }
                }
            }
        }
    
}
/// IDEA
// 1. method that checks update
// returns that file has changed like true false , endpoint in flask
// true or false so check that new endpoint


//            var currentLocation: CLLocation!
//            locManager.requestWhenInUseAuthorization()
//            if
//               CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//               CLLocationManager.authorizationStatus() ==  .authorizedAlways
//            {
//                locManager.requestLocation()
//                guard let currentLocation = locManager.location else {
//                    locManager.requestWhenInUseAuthorization()
//                    return
//                }
//            }
//            debugPrint(currentLocation?.coordinate.latitude)
//            debugPrint(currentLocation?.coordinate.longitude)



/// BACK UP - starts here -----------------------------------------------------------------------------


//// ObservableObject (protocol ∈ Combine framework) used within custom class/model
//// (Bird is a Model) - keeps track of state used with some sort of class that can store data
//
//import Foundation
//import Alamofire
//import CoreLocation
//import SwiftLocation
//// import Combine?
//
//class Api: ObservableObject {
//    // @Published before a property - will update any SwiftUI views that are watching for changes (lets swift know to watch for changes of this variable)
//
//    @Published var birds = [Bird]();
//    var sessionManager: Alamofire.Session?;
//    var latitude: CLLocationDegrees?
//    var longitude: CLLocationDegrees?
//
//    // initializing an alamofire session instance
//    init() {
//        let configuration = URLSessionConfiguration.af.default;
//
//        // flask response takes from 45 sec -1 min - so it doesn't time out before this time
//        configuration.timeoutIntervalForRequest = 180;
//
//        // Alamofire instance
//        sessionManager = Alamofire.Session(configuration: configuration, startRequestsImmediately: true);
//    }
//
//    func loadData(completion:@escaping ([Bird]) -> ()) {
//        guard let url = URL(string: "http://127.0.0.1:5000/jsonfile") else {
//            print("Invalid url...")
//            return
//        }
//        // URLSession class -  API for downloading and uploading data from and to endpoints
//        // indicated by URLs (app creates one or more URLSession instances - each coordinating
//        // a group of related data-transfer tasks).
//        // URLSession has singleton shared session for basic requests
//        // Within a session, you create tasks that optionally upload data to a server and then
//        // retrieve data from the server either as a file on disk or as one or more NSData objects
//        // in memory. Data tasks send and receive data using NSData objects.
//        // dataTask(with:completionHandler:) - creates task - 1 retreives URL contents based
//        // on specified URL req object, 2 calls handler upon completion
//        //(with: url) - URL request object
//        //{ data, response, error ....  - completionHandler
//        // data: data returned by the server
//        // response: object with response metadata (headers, status code)
//        //error: object indicating why request failed or nil if req was successful
//
//        // completion handler
//        URLSession.shared.dataTask(with: url) {data, response, error in
//            let birds = try! JSONDecoder().decode([Bird].self, from: data!)
//            print(birds)
//            DispatchQueue.main.async {
//                completion(birds)
//            }
//        //After you create the task, you must start it by calling its resume() method.
//        }.resume()
//    } // end loadData
//
//
//
//
//
//    // embed audio file
//        // URLSession.shared.(pass in audio file) (upload the bird audio file)
//        // once I upload it, I'll have completion handler { like ... data, response, error
//        // and inside comletion handler,
//        // here it's finished uploading but because of setup I don't have an indicator of when it's analyzing
//        // first hard code time a minute to wait for it because don't have indicator
//        // method that checks if file has changed ( check update method)
//       // call load data function = it'll pull whatever it has
////    }
//
//
//        func uploadData(audioFile: URL, completion:@escaping ([Bird]) -> ()) {
//
//            SwiftLocation.gpsLocation().then {
//                self.latitude = $0.location!.coordinate.latitude
//                self.longitude = $0.location!.coordinate.longitude
//                debugPrint("Location is \(self.latitude!), \(self.longitude!)")
//
//                struct HTTPBinResponse: Decodable {let results: [Bird]}
//                let data: Data? = try? Data(contentsOf: audioFile)
//
//                var headers: HTTPHeaders = HTTPHeaders.default
//                headers.add(HTTPHeader(name: "latitude", value: "\(self.latitude!)"))
//                headers.add(HTTPHeader(name: "longitude", value: "\(self.longitude!)"))
//                (self.sessionManager)!.upload(data!, to: "http://127.0.0.1:5000/bird_stream", headers: headers).responseJSON {
//                    response in
//                    debugPrint(response)
//                    guard let data = response.data else { return }
//                    // if this birds is empty display
//                    let birds = try! JSONDecoder().decode([Bird].self, from: data)
//                    /// Reload the  view using the main dispatch queue
//                    DispatchQueue.main.async {
//                        completion(birds)
//                        /// loading false
//
//                    // else the no results found on screen, on the catch I can use 400 response
//                    }
//                }
//            }
//        }
//
//}
///// IDEA
//// 1. method that checks update
//// returns that file has changed like true false , endpoint in flask
//// true or false so check that new endpoint
//
//
////            var currentLocation: CLLocation!
////            locManager.requestWhenInUseAuthorization()
////            if
////               CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
////               CLLocationManager.authorizationStatus() ==  .authorizedAlways
////            {
////                locManager.requestLocation()
////                guard let currentLocation = locManager.location else {
////                    locManager.requestWhenInUseAuthorization()
////                    return
////                }
////            }
////            debugPrint(currentLocation?.coordinate.latitude)
////            debugPrint(currentLocation?.coordinate.longitude)
