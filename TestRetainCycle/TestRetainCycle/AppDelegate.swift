//
//  AppDelegate.swift
//  TestRetainCycle
//
//  Created by VincentPro on 2022/10/31.
//

import UIKit
import LifetimeTracker

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = FirstViewController()
        
        let secondVC = UIViewController()
        secondVC.view?.backgroundColor = .orange
        
        let thirdVC = UIViewController()
        thirdVC.view?.backgroundColor = .green
        
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.backgroundColor = .white
        tabBarVC.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        tabBarVC.viewControllers?[0].tabBarItem = UITabBarItem(title: "第一頁",
                                                               image: UIImage(systemName: "gamecontroller.fill"),
                                                               selectedImage: nil)
        tabBarVC.viewControllers?[1].tabBarItem = UITabBarItem(title: "第二頁",
                                                               image: UIImage(systemName: "house.fill"),
                                                               selectedImage: nil)
        tabBarVC.viewControllers?[2].tabBarItem = UITabBarItem(title: "第三頁",
                                                               image: UIImage(systemName: "dpad.down.filled"),
                                                               selectedImage: nil)
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
#if DEBUG
            LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration(visibility: .visibleWithIssuesDetected, style: .circular).refreshUI)
#endif
        return true
    }

}

