//
//  FluxDetailViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/10.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class FluxDetailViewController: UIViewController {

    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - setup views
    
    private func _setupViews() {
        _setupNavigationBar()
    }
    
    private func _setupNavigationBar() {
        title = ""
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: Selector("tapNavigationBarShareButton:")),
            UIBarButtonItem(title: "like", style: UIBarButtonItemStyle.Done, target: self, action: Selector("tapNavigaionBarLikeButton:"))
        ]
        
        // custom back button text
        self.navigationController!.navigationBar.topItem!.title = ""
    }
    
    // MARK: - user actions
    
    func tapNavigaionBarLikeButton(sender: UIBarButtonItem) {
        // TODO: complete function
    }
    
    func tapNavigationBarShareButton(sender: UIBarButtonItem) {
        // TODO: complete function
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailContainerSegue" {
            if let detailTableViewController = segue.destinationViewController as? FluxDetailTableViewController {
                detailTableViewController.id = id
            }
        }
    }


}
