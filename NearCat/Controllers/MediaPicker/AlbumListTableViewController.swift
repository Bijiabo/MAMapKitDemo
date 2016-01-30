//
//  AlbumListTableViewController.swift
//  NCPhotoViewer
//
//  Created by huchunbo on 16/1/21.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import Photos

class AlbumListTableViewController: UITableViewController {
    
    var moments: PHFetchResult!
    var albums: PHFetchResult!
    var mediaPickerDelegate: MediaPickerDelegate?
    var counterView: UILabel?
    var selectedIndexPathData:[String: [[NSIndexPath]]] = [
        "moment": [[NSIndexPath]](),
        "album": [[NSIndexPath]]()
    ]
    var selectMaximum: Int = 9

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
        _setupAlbumData()
        
        tableView.separatorStyle = .None
        
        // setup navigation bar buttons
        counterView = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        counterView?.text = "0"
        Helper.UI.setLabel(counterView!, forStyle: Constant.TextStyle.Cell.Small.White)
        counterView?.textAlignment = .Center
        counterView?.textColor = UIColor.whiteColor()
        counterView?.backgroundColor = Constant.Color.Theme
        counterView?.layer.cornerRadius = 10.0
        counterView?.clipsToBounds = true
        let counterButton = UIBarButtonItem(customView: counterView!)
        let okButton = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapDoneButton:"))
        
        navigationItem.rightBarButtonItems = [okButton, counterButton]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if _hasBeenDisappeared {
            tableView.reloadData()
        }
    }
    
    private var _hasBeenDisappeared: Bool = false
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _hasBeenDisappeared = true
    }
    
    private func _setupViews() {
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = tableFooterView
        
        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1 // moments == nil ? 0 : moments!.count
        default:
            return albums == nil ? 0 : albums!.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("albumListCell", forIndexPath: indexPath) as! AlbumListTableViewCell
            let currentData = moments.objectAtIndex(indexPath.row) as? PHAssetCollection
            
            cell.titleLabel.text = "时刻"
            
            let assets = PHAsset.fetchAssetsInAssetCollection(currentData!, options: nil)
            
            cell.count = moments.count
            
            let targetSize = CGSize(width: 60.0, height: 60.0)
            
            _displayImageForAsset(assets.lastObject as! PHAsset, targetSize: targetSize, block: { (image) -> Void in
                cell.previewImage0 = image
            })
            if assets.count > 1 {
                _displayImageForAsset(assets.objectAtIndex(assets.count-2) as! PHAsset, targetSize: targetSize, block: { (image) -> Void in
                    cell.previewImage1 = image
                })
            }
            if assets.count > 2 {
                _displayImageForAsset(assets.objectAtIndex(assets.count-3) as! PHAsset, targetSize: targetSize, block: { (image) -> Void in
                    cell.previewImage2 = image
                })
            }
            
            cell.selectedCount = selectedIndexPathData["moment"]![0].count
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("albumListCell", forIndexPath: indexPath) as! AlbumListTableViewCell
            let currentData = albums?.objectAtIndex(indexPath.row) as? PHAssetCollection
            
            cell.titleLabel.text = currentData?.localizedTitle
            
            let assets = PHAsset.fetchAssetsInAssetCollection(currentData!, options: nil)
            
            cell.count = assets.count
            
            let targetSize = CGSize(width: 120.0, height: 120.0)
            PHImageManager.defaultManager().requestImageForAsset(assets.lastObject as! PHAsset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info: [NSObject : AnyObject]?) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.previewImage0 = image!
                })
            })
            
            cell.assetCollection = currentData
            cell.selectedCount = selectedIndexPathData["album"]![indexPath.row].count
            
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {return}
        switch segueIdentifier {
        case "linkToPreviewCollectionView":
            guard let targetVC = segue.destinationViewController as? PreviewCollectionViewController else {return}
            guard let cell = sender as? AlbumListTableViewCell else {return}
            guard let indexPath = tableView.indexPathForCell(cell) else {return}
            
            targetVC.assetsCollection = cell.assetCollection
            targetVC.mediaPickerDelegate = self.mediaPickerDelegate
            targetVC.albumListVC = self
            
            if indexPath.section == 0 {
                targetVC.momentMode = true
                
                if selectedIndexPathData["moment"]!.count > 0 {
                    targetVC.selectedImageIndexPaths = selectedIndexPathData["moment"]![0]
                }
            } else {
                if selectedIndexPathData["album"]!.count > indexPath.row {
                    targetVC.selectedImageIndexPaths = selectedIndexPathData["album"]![indexPath.row]
                }
            }
        default:
            break
        }
    }
    
    func updateSelectedIndexPathForAssetCollection(assetCollection assetCollection: PHAssetCollection?, selectedIndexPaths: [NSIndexPath], isMoment: Bool) {
        if isMoment {
            selectedIndexPathData["moment"]?[0] = selectedIndexPaths
        } else {
            if let assetCollection = assetCollection {
                let indexForAlbums = albums.indexOfObject(assetCollection)
                selectedIndexPathData["album"]?[indexForAlbums] = selectedIndexPaths
            }
        }
        
        updateSelectedCounter()
    }
    
    func updateSelectedCounter() {
        counterView?.text = "\(selectedCount)"
    }
    
    var selectedCount: Int {
        get {
            var _count: Int = 0
            if let momentSelected = selectedIndexPathData["moment"]?[0] {
                _count += momentSelected.count
            }
            
            if let albumSelectedData = selectedIndexPathData["album"] {
                for item in albumSelectedData {
                    _count += item.count
                }
            }
            
            return _count
        }
    }
    
    private func _displayImageForAsset(asset: PHAsset, targetSize: CGSize, block: (image: UIImage)->Void) {
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info: [NSObject : AnyObject]?) -> Void in
            guard let image = image else {return}
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                block(image: image)
            })
        })
    }
    
    // MARK: - user actions
    
    @IBAction func tapDismissButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - load data

extension AlbumListTableViewController {
    
    private func _setupAlbumData() {
        // get albums
        let userAlbumsOptions: PHFetchOptions = PHFetchOptions()
        userAlbumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0", argumentArray: nil)
        let userAlbums: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: userAlbumsOptions)
        albums = userAlbums
        selectedIndexPathData["album"] = [[NSIndexPath]](count: userAlbums.count, repeatedValue: [NSIndexPath]())
        
        // get moments
        let userMomentsOptions: PHFetchOptions = PHFetchOptions()
        userMomentsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0", argumentArray: nil)
        let userMoments: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Moment, subtype: PHAssetCollectionSubtype.AlbumRegular, options: userMomentsOptions)
        moments = userMoments
        selectedIndexPathData["moment"] = [[NSIndexPath]](count: 1, repeatedValue: [NSIndexPath]())
    }
    
}
