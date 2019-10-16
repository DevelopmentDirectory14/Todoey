//
//  AppDelegate.swift
//  Todoey-2
//
//  Created by Aleksey Shapoval on 10/3/19.
//  Copyright © 2019 VoVa LLC. All rights reserved.
//  Test

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try! Realm()
            
        } catch {
            print("Error loading Realm object, \(error)")
        }
        
        
       
    return true






    }
    
    
}

