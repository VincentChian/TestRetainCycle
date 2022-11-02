//
//  DefaultLifetimeTrackableVC.swift
//  TestRetainCycle
//
//  Created by VincentPro on 2022/11/1.
//

import UIKit
import LifetimeTracker

class DefaultLifetimeTrackableVC: UIViewController, LifetimeTrackable {
    
    private lazy var middleLabel: UILabel = UILabel()
    
    // MARK: LifetimeTracker
    static var lifetimeConfiguration: LifetimeConfiguration = LifetimeConfiguration(maxCount: 0, groupName: "")

    
    convenience init(configMaxCount: Int,
                     configGroupName: String,
                     isTrackLifetime: Bool) {
        
        self.init(nibName: nil, bundle: nil)
        DefaultLifetimeTrackableVC.lifetimeConfiguration.maxCount = configMaxCount
        DefaultLifetimeTrackableVC.lifetimeConfiguration.groupName = configGroupName
        if isTrackLifetime {
            trackLifetime()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleLabel()
    }
    
    private func setupMiddleLabel() {
        view.addSubview(middleLabel)
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - API
    func setTitle(text: String) {
        middleLabel.text = text
    }
}
