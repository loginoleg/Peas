//
//  AuthenticationViewController.swift
//  Peas
//
//  Created by IOS on 2/14/17.
//  Copyright © 2017 Oleg. All rights reserved.
//

import Cocoa
import WebKit

class AuthenticationViewController: NSViewController, WebFrameLoadDelegate {
    
    @IBOutlet weak var webView: WebView!
    var accessToken: String? = nil
    let token = "#access_token="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: String = String(format: "https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=public_content", InstagramHelper.clientID, InstagramHelper.redirectURI)
        
        let authRequest = URLRequest(url: URL(string: url)!)
        webView.mainFrame.load(authRequest)
        webView.frameLoadDelegate = self
        
        
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        
        if sender.mainFrameURL.contains(token) {
            let rangeOfToken = sender.mainFrameURL.range(of: String(describing: "="), options: .backwards)
            accessToken = sender.mainFrameURL.substring(from: (rangeOfToken?.upperBound)!)
            NetworkManager.shared.accessToken = accessToken
            self.dismiss(nil)
        }
        
    }
    
    func getSomething() {
        print("getSomething")
    }
    
}
