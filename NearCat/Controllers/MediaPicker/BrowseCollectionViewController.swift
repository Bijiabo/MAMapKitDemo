//
//  BrowseCollectionViewController.swift
//  NCPhotoViewer
//
//  Created by huchunbo on 16/1/22.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "browseCell"
private let cellSpacing: CGFloat = 0

class BrowseCollectionViewController: UICollectionViewController {

    var assetsCollection: PHAssetCollection?
    var data: PHFetchResult!
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var startIndexPath: NSIndexPath?
    var mediaPickerDelegate: MediaPickerDelegate?
    var previewCollectionVC: PreviewCollectionViewController?
    var albumListVC: AlbumListTableViewController?
    var sectionIndexForPreviewList: Int = 0
    
    var counterView: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupData()

        // setup flow layout
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.minimumInteritemSpacing = cellSpacing
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        collectionView?.collectionViewLayout = flowLayout
        
        collectionView?.pagingEnabled = true
        collectionView?.contentInset = UIEdgeInsetsZero
        automaticallyAdjustsScrollViewInsets = false
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        if let startIndexPath = startIndexPath {
            collectionView?.scrollToItemAtIndexPath(startIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
        
        // setup navigation bar buttons
        counterView = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        counterView?.text = "\(albumListVC == nil ? 0 : albumListVC!.selectedCount)"
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
        updateNavigationBarDisplay(display: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updateNavigationBarDisplay(display: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: user action
    
    func tapDoneButton(sender: AnyObject) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BrowseCollectionViewCell
        let currentData = data.objectAtIndex(indexPath.row) as! PHAsset
        let targetSize = view.bounds.size
        PHImageManager.defaultManager().requestImageForAsset(currentData, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info: [NSObject : AnyObject]?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.image = image!
            })
            
        })
        
        if let creationDate = currentData.creationDate {
            cell.date = creationDate
        }
        
        if let previewCollectionVC = previewCollectionVC {
            if previewCollectionVC.selectedImageIndexPaths.contains(NSIndexPath(forRow: indexPath.row, inSection: sectionIndexForPreviewList)) {
                cell.select = true
            } else {
                cell.select = false
            }
        }
        
        
        cell.width = currentData.pixelWidth
        cell.height = currentData.pixelHeight
        cell.indexPath = indexPath
        cell.browseDelegate = self
    
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "browseFooter", forIndexPath: indexPath) //as! PreviewHeaderCollectionReusableView
            
            return headerView
        }
        
        let reusableView: UICollectionReusableView! = nil
        return reusableView
    }

    func toggleNavigationBarDisplay() {
        if navigationController?.navigationBar.alpha == 0 {
            updateNavigationBarDisplay(display: true)
            toggleCellFooter(display: true)
        } else {
            updateNavigationBarDisplay(display: false)
            toggleCellFooter(display: false)
        }
    }
    
    func toggleCellFooter(display display: Bool) {
        for cell in collectionView?.visibleCells() as! [BrowseCollectionViewCell] {
            cell.displayFooter = display
        }
    }
    
    func updateNavigationBarDisplay(display display: Bool) {
        UIApplication.sharedApplication().setStatusBarHidden(!display, withAnimation: UIStatusBarAnimation.Fade)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.navigationController?.navigationBar.alpha = display ? 1.0 : 0.0
            }, completion: nil)
        
        navigationController?.extension_backgroundTransparent(!display)
    }
    
}

// MARK: - data functions

extension BrowseCollectionViewController {
    
    private func _setupData() {
        guard let assetsCollection = assetsCollection else {return}
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        data = PHAsset.fetchAssetsInAssetCollection(assetsCollection, options: fetchOptions)
        print(data.count)
    }
}

// MARK: - flow layout delegate

extension BrowseCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension BrowseCollectionViewController: BrowsePhotoDelegate {
    
    func tapPreviewView() {
        toggleNavigationBarDisplay()
    }
    
    func tapSelectButton(indexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? BrowseCollectionViewCell else {return}
        
        guard let previewCollectionVC = previewCollectionVC  else { return }
        
        let indexPathForPreviewVC = NSIndexPath(forRow: indexPath.row, inSection: sectionIndexForPreviewList)
        
        if previewCollectionVC.toggleSelectedForIndexPath(indexPathForPreviewVC) {
            cell.select = true
            
            // get image
            let currentAsset = data.objectAtIndex(indexPath.row) as! PHAsset
            let targetSize = CGSize(width: 120.0, height: 120.0)
            
            dispatch_async(Helper.MultiThread.Queue.Concurent, { () -> Void in
                PHImageManager.defaultManager().requestImageForAsset(currentAsset, targetSize: targetSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (image, info: [NSObject : AnyObject]?) -> Void in
                    guard let image = image else {return}
                    
                    if let navigationVC = self.navigationController as? MediaPickerNavigationViewController {
                        navigationVC.selectedImages.append(image)
                    }
                })
            })
        } else {
            cell.select = false
        }

        
        // update navigation bar selecte counter display
        guard let albumListVC = albumListVC else {return}
        counterView?.text = "\(albumListVC.selectedCount)"
    }
}


