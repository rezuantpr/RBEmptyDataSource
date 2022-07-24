//
//  AppDelegate.swift
//  Example
//
//  Created by Rezuan Bidzhiev on 24.07.2022.
//

import UIKit
import RBEmptyDataSource

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = ViewController()
    window?.backgroundColor = .white
    return true
  }

}

