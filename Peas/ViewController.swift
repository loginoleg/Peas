//
//  ViewController.swift
//  Peas
//
//  Created by IOS on 2/10/17.
//  Copyright © 2017 Oleg. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WebFrameLoadDelegate {
    
    @IBOutlet weak var webView: WebView!
    var accessToken: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let clientID = ""
//        let redirectURI = "http://github.com/loginoleg"
//        
//        let url: String = String(format: "https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=public_content", clientID, redirectURI)
//        
//        let authRequest = URLRequest(url: URL(string: url)!)
//        webView.mainFrame.load(authRequest)
//        webView.frameLoadDelegate = self
        
        NetworkManager.shared.accessToken = "2512426.c4f98c9.a819c7fd6b9a44a3b49d29226012690f"

    }

    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        print(sender.mainFrameURL)
        if sender.mainFrameURL.contains("#access_token=") {
            let rangeOfToken = sender.mainFrameURL.range(of: "=", options: .backwards)
            accessToken = sender.mainFrameURL.substring(from: (rangeOfToken?.upperBound)!)
            NetworkManager.shared.accessToken = accessToken
            getSomething()
        }
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        getSomething()
    }
    
    func getSomething() {
        self.performSegue(withIdentifier: "toBrowserViewControllerSegue", sender: self)

    }
    

    override var representedObject: Any? {
        didSet {
        }
    }
    
}

