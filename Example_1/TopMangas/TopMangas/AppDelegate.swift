//
//  AppDelegate.swift
//  TopMangas
//
//  Created by iamchiwon on 2018. 8. 16..
//  Copyright © 2018년 iamchiwon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        application.statusBarStyle = .lightContent

        let navi = UINavigationController(rootViewController: ViewController())
        navi.navigationBar.isTranslucent = true
        navi.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navi.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        navi.navigationBar.tintColor = UIColor.white
        navi.hidesBarsOnSwipe = true

        window = UIWindow()
        window?.rootViewController = navi
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()

        return true
    }

}

