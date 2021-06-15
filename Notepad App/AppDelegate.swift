//
//  AppDelegate.swift
//  Notepad App
//
//  Created by Mahmoud Ismail on 6/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initAppCoordinator()
        return true
    }
    
    private func initAppCoordinator(){
       
        if #available (iOS 13.0, *) {
            // will go to SceneDelegate cuz 13 iOS
            }else{
            self.coordinator = AppCoordinator()
            self.coordinator.start()
        }
    }

}

