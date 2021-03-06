//
//  PhotoCVItem.swift
//  Peas
//
//  Created by IOS on 2/13/17.
//  Copyright © 2017 Oleg. All rights reserved.
//

import Cocoa

class PhotoCVItem: NSCollectionViewItem {

    @IBOutlet weak var titleTF: NSTextField!
    @IBOutlet weak var photoIV: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.brown.cgColor
    }
    
    func setData(_ title: String) {
        self.titleTF.stringValue = title
        let url = title
        
        let image = NSImage(contentsOf: URL(string: url)!)
        photoIV.image = image
    }
    
    
    override func mouseDown(with event: NSEvent) {
        
    }
    
    
}
