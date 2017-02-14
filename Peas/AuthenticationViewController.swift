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
        
        let clientID = ""
        let redirectURI = "http://github.com/loginoleg"
        
        let url: String = String(format: "https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=public_content", clientID, redirectURI)
        
        let authRequest = URLRequest(url: URL(string: url)!)
        webView.mainFrame.load(authRequest)
        webView.frameLoadDelegate = self
        
        //        NetworkManager.shared.accessToken = "2512426.c4f98c9.a819c7fd6b9a44a3b49d29226012690f"
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        
        if sender.mainFrameURL.contains(token) {
            let rangeOfToken = sender.mainFrameURL.range(of: String(describing: token.characters.last), options: .backwards)
            accessToken = sender.mainFrameURL.substring(from: (rangeOfToken?.upperBound)!)
            NetworkManager.shared.accessToken = accessToken
            self.dismiss(nil)
        }
        
    }
    
    func getSomething() {
        print("getSomething")
    }
    
}
