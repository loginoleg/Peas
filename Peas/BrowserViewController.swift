//
//  BrowserViewController.swift
//  Peas
//
//  Created by IOS on 2/13/17.
//  Copyright © 2017 Oleg. All rights reserved.
//

import Cocoa

class BrowserViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var searchBarTF: NSTextField!
    var imagesURL: Array<String>?
    var sourceData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkManager.shared.accessToken = "2512426.c4f98c9.a819c7fd6b9a44a3b49d29226012690f"
        
        configureCollectionView()
        getImagesBy()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let authVC = storyboard.instantiateController(withIdentifier: "AuthenticationViewController")
        presentViewControllerAsSheet(authVC as! NSViewController)
    }
    
    // MARK: - IBAction
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let tag: String = searchBarTF.stringValue
        getImagesBy([tag])
    }
    
    // MARK: - CollectionView
    
    func configureCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.blue.cgColor
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: "PhotoCVItem", for: indexPath)
        
        guard let collectionViewItem = item as? PhotoCVItem else {
            return item
        }
        
        collectionViewItem.setData(sourceData[indexPath.item])
        
        return item
    }
    
    
    func updateUI() {
        collectionView.reloadData()
    }
    
    
    func getImagesBy(_ tags: Array<String>? = nil) {
        
        guard tags != nil else {
            return
        }
        
        let accessToken = NetworkManager.shared.accessToken
        
        //        let tags = "surfinua"
        let url = String(format: "https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@", (tags?.first)!, accessToken!)
        
        var images = [String]()
        
        let task = URLSession.shared.dataTask(with:URL(string: url)!) { (data, response, error) in
            if data != nil {
                let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                
                let data = json?["data"] as! Array<Any>
                
                for item in data as! Array<Dictionary<String, Any>> {
                    print(item["images"] ?? "not images")
                    let imageItems: Dictionary<String, Any> = item["images"] as! Dictionary<String, Any>
                    let imageItem: Dictionary<String, Any> = imageItems["standard_resolution"] as! Dictionary<String, Any>
                    let imageURL: String = imageItem["url"] as! String
                    
                    images.append(imageURL)
                }
                
                print(images)
                self.sourceData.append(contentsOf: images)
                self.updateUI()
            }
        }
        
        task.resume()
    }
}
