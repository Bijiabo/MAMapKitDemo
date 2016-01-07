//
//  ViewController.swift
//  NearCat
//
//  Created by huchunbo on 15/12/23.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import UIKit
import SwiftyJSON

let APIKey = "3b17386d0a14ac347b70d4bc205ee6ff"

class ViewController: UIViewController ,MAMapViewDelegate, AMapSearchDelegate{
    
    var mapView:MAMapView?
    var search:AMapSearchAPI?
    var currentLocation:CLLocation?

    @IBOutlet weak var segmentedControl: SegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResults: [AMapPOI] = [AMapPOI]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup AMap API key
        MAMapServices.sharedServices().apiKey = APIKey
        AMapSearchServices.sharedServices().apiKey = APIKey
        
        initNavigationBar()
        
        initSearch()
        
        initSearchBar()
        
        searchDisplayController!.searchResultsTableView.registerClass(SearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        
        Location.sharedInstance.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        initMapView()
        
        _regionChangeCount = 45
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        mapView?.removeFromSuperview()
        mapView = nil
    }
    
    /**
     setup navigation bar title view -> UISegmentedControl
     
     - returns: Void
     */
    func initNavigationBar() {
        /*
        // setup navigation bar title view
        let segmentedControlItems = [
            "All",
            "Type 1",
            "Type 2"
        ]
        let titleView = SegmentedControl() //UISegmentedControl(items: segmentedControlItems)
        titleView.selectedIndex = 0
        let titleViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width-40.0, height: titleView.frame.size.height)
        titleView.frame = titleViewFrame
        titleView.items = segmentedControlItems
        navigationItem.titleView = titleView
        */
        segmentedControl.items = ["全部", "公猫", "母猫"]
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.translucent = false
        navigationBar?.setBackgroundImage(UIImage(named: "white"), forBarMetrics: UIBarMetrics.Default)
        navigationBar?.shadowImage = UIImage()
        
        navigationController?.setNavigationBarHidden(true, animated: false) // TODO: 添加性别分类功能后显示
    }
    
    func initMapView(){
        
        var mapViewFrame = view.bounds
        mapViewFrame.origin.y = searchBar.frame.height + searchBar.frame.origin.y
        mapViewFrame.size.height -= mapViewFrame.origin.y
        mapView = MAMapView(frame: mapViewFrame)
        
        mapView!.delegate = self
        
        view.addSubview(mapView!)
        view.sendSubviewToBack(mapView!)
        
        let compassX = mapView?.compassOrigin.x
        
        let scaleX = mapView?.scaleOrigin.x
        
        //设置指南针和比例尺的位置
        mapView?.compassOrigin = CGPointMake(compassX!, 21)
        
        mapView?.scaleOrigin = CGPointMake(scaleX!, 21)
        
        // 开启定位
        mapView!.showsUserLocation = true
        
        // 设置跟随定位模式，将定位点设置成地图中心点
        mapView!.userTrackingMode = MAUserTrackingMode.Follow
        
        mapView?.showsCompass = true
        mapView?.compassOrigin = CGPointMake(view.bounds.width-50.0, view.bounds.height-50.0)
        mapView?.showsScale = false
        mapView?.zoomEnabled = true
        mapView?.rotateEnabled = true
        mapView?.zoomLevel = 14.0
        mapView?.customizeUserLocationAccuracyCircleRepresentation = true
        mapView?.setCompassImage(UIImage(named: "doge"))
    }
    
    // 初始化 AMapSearchAPI
    func initSearch(){
        search = AMapSearchAPI()
        search?.delegate = self
            //AMapSearchAPI(searchKey: APIKey, delegate: self)
    }
    
    // 逆地理编码
    func reverseGeocoding(){
        /*
        let coordinate = currentLocation?.coordinate
        
        // 构造 AMapReGeocodeSearchRequest 对象，配置查询参数（中心点坐标）
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        
        regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate!.latitude), longitude: CGFloat(coordinate!.longitude))
        
        print("regeo :\(regeo)")
        
        // 进行逆地理编码查询
        self.search!.AMapReGoecodeSearch(regeo)
        */
    }

    // MARK: - MAMapViewDelegate
    
    // 定位回调
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
    }
    
    private var _regionChangeCount: Int = 40
    
    func mapView(mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
        if _regionChangeCount % 50 == 0 { // delay to cut down request nearby cat rate
            _regionChangeCount = 0
            
            print("regionDidChangeAnimated")
            _removeAllAnnotation()
            
            let currentLocation = mapView.centerCoordinate
            Action.cats.nearby(currentLocation.latitude, longitude: currentLocation.longitude, completeHandler: { (success, data, description) -> Void in
                
                for (_, dataItem): (String, JSON) in data {
                    let age = dataItem["age"].intValue
                    let itemLocation = CLLocationCoordinate2D(latitude: dataItem["latitude"].doubleValue, longitude: dataItem["longitude"].doubleValue)
                    self.addAnnotation(location: itemLocation, title: dataItem["name"].stringValue, subTitle: "\(age)岁")
                }
            })
        }
        
        _regionChangeCount += 1
    }
    
    // 点击Annoation回调
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        // 若点击的是定位标注，则执行逆地理编码
        if view.annotation.isKindOfClass(MAUserLocation){
            reverseGeocoding()
        }
    }
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation) {
            let pointReuseIndentifier = "pointReuseIndentifier"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(pointReuseIndentifier) as? CatAnnotationView
            
            if annotationView == nil {
                annotationView = CatAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndentifier)
                    // MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndentifier)
            }
            
            annotationView?.image = UIImage(named: "pin") //custom pin image
            annotationView?.canShowCallout = false
            annotationView?.draggable = false
            annotationView?.calloutImage = UIImage(named: "Icon-76")
            
            return annotationView!
        } else if annotation.isKindOfClass(MAUserLocation) {
            let pointReuseIndentifier = "myLocationReuseIndentifier"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(pointReuseIndentifier)
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndentifier)
            }
            
            annotationView.image = UIImage(named: "myLoationAnnotation") //custom pin image
            annotationView.canShowCallout = true
            annotationView.draggable = true
            return annotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MAMapView!, didAnnotationViewCalloutTapped view: MAAnnotationView!) {
        print("didAnnotationViewCalloutTapped")
    }
    
    func mapView(mapView: MAMapView!, viewForOverlay overlay: MAOverlay!) -> MAOverlayView! {
        // 自定义精度圈（MACircle）样式
        
        if mapView.userLocationAccuracyCircle as NSObject == overlay as! NSObject {
            let accuracyCircleView: MACircleView = MACircleView(circle: overlay as! MACircle)
            
            accuracyCircleView.lineWidth    = 2.0
            accuracyCircleView.strokeColor  = UIColor.clearColor() // UIColor.lightGrayColor()
            accuracyCircleView.fillColor    = UIColor.clearColor() // UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.3)
            
            return accuracyCircleView
        }
        
        return nil
    }
    
    private func _removeAllAnnotation() {
        guard let annotations = mapView?.annotations as? [MAAnnotation] else {return}
        for annotation in annotations {
            if !annotation.isKindOfClass(MAUserLocation) {
                mapView?.removeAnnotation(annotation)
            }
        }
    }

    // 逆地理编码回调
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest, response: AMapReGeocodeSearchResponse) {
        
        print("request :\(request)")
        print("response :\(response)")
        
        if (response.regeocode != nil) {
            let coordinate = CLLocationCoordinate2DMake(Double(request.location.latitude), Double(request.location.longitude))
            
            let annotation = MAPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = response.regeocode.formattedAddress
            annotation.subtitle = response.regeocode.addressComponent.province
            mapView!.addAnnotation(annotation)
            
            let overlay = MACircle(centerCoordinate: coordinate, radius: 50.0)
            mapView!.addOverlay(overlay)
        }
    }

}

extension ViewController {
    func addAnnotation(location location: CLLocationCoordinate2D, title: String, subTitle: String) {
        let pointAnnotation: MAPointAnnotation = MAPointAnnotation()
        pointAnnotation.coordinate = location
        pointAnnotation.title = title
        pointAnnotation.subtitle = subTitle

        mapView?.addAnnotation(pointAnnotation)
    }
    
    func initSearchBar() {
        view.bringSubviewToFront(searchBar)
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        
        searchBar.layer.shadowColor = UIColor.blackColor().CGColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        searchBar.layer.shadowRadius = 0
        searchBar.layer.shadowOpacity = 0.1
        
        let tableFooterView: UIView = UIView()
        tableFooterView.backgroundColor = UIColor.clearColor()
        searchDisplayController?.searchResultsTableView.tableFooterView = tableFooterView
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchKeywords = searchBar.text else {return}
        //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
        let request: AMapPOIAroundSearchRequest = AMapPOIAroundSearchRequest()
        let latitude: CGFloat = CGFloat(mapView!.centerCoordinate.latitude)
        let longitude:CGFloat = CGFloat(mapView!.centerCoordinate.longitude)
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
    
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0
        {
            return
        }
        
        searchResults = [AMapPOI]()
        
        //通过 AMapPOISearchResponse 对象处理搜索结果
        let strCount: String = "count: \(response.count)"
        let strSuggestion: String = "Suggestion: \(response.suggestion)"
        var strPoi: String = ""
        for p in response.pois as! [AMapPOI] {
            strPoi = "\(strPoi)\nPOI: \(p.name)"
            searchResults.append(p)
        }
        let result: String = "\(strCount) \n \(strSuggestion) \n \(strPoi)"
        // NSLog("Place: %@", result);
        
        searchDisplayController?.searchResultsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultTableViewCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        
        cell.name = searchResults[indexPath.row].name
        cell.distance = searchResults[indexPath.row].distance
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard searchResults.count > indexPath.row else {return}
        
        let latitude: Double = Double(searchResults[indexPath.row].location.latitude)
        let longitude: Double = Double(searchResults[indexPath.row].location.longitude)
        
        let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        searchDisplayController?.setActive(false, animated: false)
        
        mapView?.setCenterCoordinate(centerLocation, animated: true)
    }
}

extension UISearchBar {
    
    var textField: UITextField? {
        for subview in subviews as [UIView] {
            if let textField = subview as? UITextField {
                return textField
            }
        }
        return nil
    }
}

