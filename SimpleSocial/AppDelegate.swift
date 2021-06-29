//
//  AppDelegate.swift
//  Simple Social
//
//  Created by Elvis Mwenda on 29/06/2021.
//

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StyleHelper.setStyle()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeController())
        window?.makeKeyAndVisible()
        return true
    }
}
