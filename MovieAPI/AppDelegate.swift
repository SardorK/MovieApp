//
//  AppDelegate.swift
//  MovieAPI
//
//  Created by User 2 on 09/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let viewController = ViewController()
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = viewController
        return true
    }



}

