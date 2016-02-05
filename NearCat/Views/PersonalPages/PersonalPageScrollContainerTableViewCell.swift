//
//  PersonalPageScrollContainerTableViewCell.swift
//  NearCat
//
//  Created by huchunbo on 16/2/5.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit

class PersonalPageScrollContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollContainerView: UIScrollView!
    
    weak var personalPageTVCDelegate: PersonalPageTableViewController? {
        didSet {
            mainPageVC?.parentTVCDelegate = personalPageTVCDelegate
            fluxPageVC?.parentTVCDelegate = personalPageTVCDelegate
            catPageVC?.parentTVCDelegate = personalPageTVCDelegate
        }
    }
    
    var verticalScrollEnabled: Bool = false {
        didSet {
            mainPageVC?.tableView.scrollEnabled = verticalScrollEnabled
            fluxPageVC?.tableView.scrollEnabled = verticalScrollEnabled
            catPageVC?.tableView.scrollEnabled = verticalScrollEnabled
            
            if mainPageVC?.tableView.contentSize.height <= mainPageVC?.view.frame.height {
                mainPageVC?.tableView.scrollEnabled = false
            }
            
            if fluxPageVC?.tableView.contentSize.height <= fluxPageVC?.view.frame.height {
                fluxPageVC?.tableView.scrollEnabled = false
            }
            
            if catPageVC?.tableView.contentSize.height <= catPageVC?.view.frame.height {
                catPageVC?.tableView.scrollEnabled = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        _setupScrollContainerView()
    }

    private func _setupScrollContainerView() {
        scrollContainerView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width*3.0, height: 0)
        scrollContainerView.delegate = self
        scrollContainerView.pagingEnabled = true
        
        _addSubViewControllers()
    }
    
    var mainPageVC: PersonalPageMianPageTableViewController?
    var fluxPageVC: PersonalPageFluxPageTableViewController?
    var catPageVC: PersonalPageCatPageTableViewController?
    
    private func _addSubViewControllers() {
        let width: CGFloat = bounds.width
        let height: CGFloat = bounds.height
        
        mainPageVC = Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "personalPageMianPageTableViewController") as? PersonalPageMianPageTableViewController
        mainPageVC?.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        mainPageVC?.tableView.bounces = false
        mainPageVC?.view.backgroundColor = Constant.Color.Pink
        scrollContainerView.addSubview(mainPageVC!.view)
        
        fluxPageVC = Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "personalPageFluxPageTableViewController") as? PersonalPageFluxPageTableViewController
        fluxPageVC?.view.frame = CGRect(x: UIScreen.mainScreen().bounds.width, y: 0, width: width, height: height)
//        fluxPageVC?.tableView.bounces = false
        fluxPageVC?.view.backgroundColor = Constant.Color.Theme
        scrollContainerView.addSubview(fluxPageVC!.view)
        
        catPageVC = Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "personalPageCatPageTableViewController") as? PersonalPageCatPageTableViewController
        catPageVC?.view.frame = CGRect(x: UIScreen.mainScreen().bounds.width*2.0, y: 0, width: width, height: height)
//        catPageVC?.tableView.bounces = false
        catPageVC?.view.backgroundColor = Constant.Color.Pink
        scrollContainerView.addSubview(catPageVC!.view)
        
    }
    
}

extension PersonalPageScrollContainerTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
}

