//
//  SceneDelegate.swift
//  AudioRecBetaUIKit
//
//  Created by Ari on 8/5/21.
//
//SceneDelegate uses delegation, of course, and one delegate typically responds to any scene. You use one delegate to configure all scenes in your app

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Scene's delegate most important function https://learnappmaking.com/scene-delegate-app-delegate-xcode-11-ios-13/
    ////  most similar to the role of the application(_:didFinishLaunchingWithOptions:) function of the app delegate.
    // function is called when a scene is added to the app, so it’s the perfect point to configure that scene
    
    /// scene delegate configures the scene, at the right time, when scene(_:willConnectTo:options:) is called
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Creates the SwiftUI view that provides the window contents.
        //// initializing and Audio recorder instance for our previous struct (contentView?), under scene function as well for the scene function on our scenedelegate.swift ContentView
        
        /// The scene(_:willConnectTo:options:) function creates a SwiftUI view, puts it in a hosting controller, assigns that to the root view controller of the window property, and puts that window at the front of the app UI
        let contentView = ContentView(audioRecorder: AudioRecorder())
        
        /// I think here I'll have to initialize the scene for the bird display?
        

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    
    /// See the symmetries between these functions? Active/inactive, background/foreground, and “disconnect”. These are typical lifecycle events for any application or process.
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

