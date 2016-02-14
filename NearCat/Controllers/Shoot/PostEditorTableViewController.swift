//
//  PostEditorTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import CoreLocation

class PostEditorTableViewController: UITableViewController {

    let locationManager = CLLocationManager()
    var location: CLLocation = CLLocation()
    var previewImage: UIImage = UIImage() {
        didSet {
            guard let editCell = editCell else {return}
            editCell.previewImageView.image = previewImage
        }
    }
    var selectedImages: [UIImage] = [UIImage]()
    
    var editCell: PostEditorTableViewCell? {
        get {
            return tableView.cellForRowAtIndexPath( NSIndexPath(forRow: 0, inSection: 0) ) as? PostEditorTableViewCell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        extension_setupFooterView()
        
        _setupViews()
        _setupLoaction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func _setupViews() {
        tableView.separatorStyle = .None
    }
    
    private func _setupLoaction() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default: //1
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 162.0
        case 1:
            return 44.0
        default:
            return 44.0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12.0
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("editCell", forIndexPath: indexPath) as! PostEditorTableViewCell
            
            return cell
        default: //indexPath.section == 1
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("postLocationCell", forIndexPath: indexPath)
                
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("postAtCell", forIndexPath: indexPath)
                
                return cell
            }
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "setLocation" {
            if let targetVC = segue.destinationViewController as? PostSetLocationTableViewController {
                targetVC.currentLocation = location
            }
        }
    }
    
    // MARK: - user actions
    
    @IBAction func tapPostButton(sender: AnyObject) {
        guard let editorCell = editCell else {return}
        editorCell.contentTextView.resignFirstResponder()
        
        let content: String = editorCell.content
        var imageData: NSData? = nil
        if !selectedImages.isEmpty {
            let firstImage: UIImage = selectedImages.first!
            imageData = UIImageJPEGRepresentation(firstImage, 1)
        }
        
        if content.characters.count > 140 {
            Helper.Alert.show(title: "文字过长", message: "为了更好的体验，我们目前将文字长度限定在 140 字以内，请修改后重新发布。", animated: true)
            return
        } else if content.characters.count == 0 && selectedImages.isEmpty {
            Helper.Alert.show(title: "内容为空", message: "没有添加任何图片和文字，没法发表哦喵。", animated: true)
            return
        }
        
        Action.fluxes.create(motion: "publish", content: content, image: imageData) { (success, description) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                print(description)
            }
        }
    }
    
    
}

extension PostEditorTableViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }
}
