//
//  AppDelegate.swift
//  Peas
//
//  Created by IOS on 2/10/17.
//  Copyright © 2017 Oleg. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NetworkManager.shared.authInstagram()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

