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
    
    let vc1 = ViewController()
    let vc2 = ViewController()
    vc1.navigationItem.title = "First"
    vc2.navigationItem.title = "Second"
      
    let nvc1 = UINavigationController(rootViewController: vc1)
    let nvc2 = UINavigationController(rootViewController: vc2)
    
    nvc1.navigationBar.prefersLargeTitles = true
    
    nvc1.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
    nvc2.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
    
    let tabbar = UITabBarController()
    tabbar.viewControllers = [nvc1, nvc2]
    
    window?.backgroundColor = .white
    
    window?.rootViewController = tabbar
    return true
  }

}

