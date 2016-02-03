//
//  PostSetLocationTableViewController.swift
//  NearCat
//
//  Created by huchunbo on 16/1/20.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import UIKit
import CoreLocation

class PostSetLocationTableViewController: UITableViewController {
    
    private var searchResults: [AMapPOI] = [AMapPOI]()
    private var resultSearchController: UISearchController = UISearchController()
    private var selectedIndexPath: NSIndexPath?
    private var search:AMapSearchAPI?
    
    var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()

        extension_setupFooterView()
        
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        
        resultSearchController.searchBar.searchBarStyle = .Minimal
        tableView.tableHeaderView = resultSearchController.searchBar
        
        resultSearchController.searchBar.delegate = self
        
        tableView.reloadData()
        
        initSearch()
    }
    
    func initSearch(){
        AMapSearchServices.sharedServices().apiKey = APIKey
        search = AMapSearchAPI()
        search?.delegate = self
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return searchResults.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCellWithIdentifier("searchLocationResultCell", forIndexPath: indexPath) as! SearchLocationResultTableViewCell
            
            cell.locationName = "当前位置"
            cell.locationInfo = "xxx xxx"
            
            return cell
        default : //indexPath.section == 1
            let cell = tableView.dequeueReusableCellWithIdentifier("searchLocationResultCell", forIndexPath: indexPath) as! SearchLocationResultTableViewCell
            let currentData = searchResults[indexPath.row]
            
            cell.locationName = currentData.name
            cell.locationInfo = currentData.address
            
            return cell
            
        }
        
    }

}

extension PostSetLocationTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchResults.removeAll(keepCapacity: false)
        
        guard let searchKeywords = searchController.searchBar.text else {return}
        //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
        let request: AMapPOIAroundSearchRequest = AMapPOIAroundSearchRequest()
        let latitude: CGFloat = CGFloat(currentLocation.coordinate.latitude)
        let longitude:CGFloat = CGFloat(currentLocation.coordinate.longitude)
        request.location = AMapGeoPoint.locationWithLatitude(latitude, longitude: longitude)
        request.keywords = searchKeywords
        // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
        // POI的类型共分为20种大类别，分别为：
        // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
        // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
        // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
        request.types = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
        request.sortrule = 0;
        request.requireExtension = true
        
        //发起周边搜索
        search?.AMapPOIAroundSearch(request)
    }
    
}

extension PostSetLocationTableViewController: AMapSearchDelegate {
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0
        {
            tableView.reloadData()
            return
        }
        
        searchResults = [AMapPOI]()
        
        //通过 AMapPOISearchResponse 对象处理搜索结果
//        let strCount: String = "count: \(response.count)"
        // let strSuggestion: String = "Suggestion: \(response.suggestion)"
        var strPoi: String = ""
        for p in response.pois as! [AMapPOI] {
            strPoi = "\(strPoi)\nPOI: \(p.name)"
            searchResults.append(p)
        }
        // let result: String = "\(strCount) \n \(strSuggestion) \n \(strPoi)"
        // NSLog("Place: %@", result);
        
        tableView.reloadData()
    }
}

extension PostSetLocationTableViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchResults.removeAll(keepCapacity: false)
        
        tableView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchResults.removeAll(keepCapacity: false)
        
        tableView.reloadData()
    }
}