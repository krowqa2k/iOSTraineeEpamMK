//
//  ViewController.swift
//  Task3AppStateChanges
//
//  Created by Mateusz Krówczyński on 14/07/2025.
//

import UIKit

class ViewController: UIViewController {
    let notificationCenter: NotificationCenter = .default

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    let appDidEnterBackgroundNotification = UIApplication.didEnterBackgroundNotification
    let appWillEnterForegroundNotification = UIApplication.willEnterForegroundNotification
    
    private func addObservers() {
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackground), name: appDidEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillEnterForeground), name: appWillEnterForegroundNotification, object: nil)
    }
    
    @objc private func appDidEnterBackground(_ notification: Notification) {
        print("App did enter background")
    }
    
    @objc private func appWillEnterForeground(_ notification: Notification) {
        print("App will enter foreground")
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: appDidEnterBackgroundNotification, object: nil)
        notificationCenter.removeObserver(self, name: appWillEnterForegroundNotification, object: nil)
        print("ViewController deinitialized and observers removed")
    }
}

