//
//  FirstViewController.swift
//  TestRetainCycle
//
//  Created by VincentPro on 2022/10/28.
//

import UIKit
import LifetimeTracker



class FirstViewController: UIViewController, LifetimeTrackable {
    
    static var lifetimeConfiguration: LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 0, groupName: "VC")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        trackLifetime()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addContentVC()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeContentVC()
    }

    
    private func addContentVC() {
        let contentVC = FirstContentViewController(configMaxCount: 1,
                                                   configGroupName: "VC",
                                                   isTrackLifetime: true)
        addChild(contentVC)
        view.addSubview(contentVC.view)
        contentVC.setRandomColor()
        contentVC.didMove(toParent: self)
    }
    
    private func removeContentVC() {
        for childVC in children where childVC is FirstContentViewController {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
    }
}

