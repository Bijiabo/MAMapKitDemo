//
//  Helper.Controller.swift
//  NearCat
//
//  Created by huchunbo on 16/1/12.
//  Copyright © 2016年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

extension Helper {
    
    public class Controller {
        
        public class func instanceForStoryboardByName(storyboardName: String, ForIdentifier identifier: String) -> UIViewController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(identifier)
        }
        
        class var Shoot: ShootNavigationViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "shootViewControllerContainer") as! ShootNavigationViewController
            }
        }
        
        class var MediaPicker: MediaPickerNavigationViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("MediaPicker", ForIdentifier: "mediaPickerNavigationVC") as! MediaPickerNavigationViewController
            }
        }
        
        class var Selection: SelectionTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "selectionTableVC") as! SelectionTableViewController
            }
        }
        
        class var FluxDetail: FluxDetailViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "fluxDetail") as! FluxDetailViewController
            }
        }
        
        class var NotificationSetting: NotificationSettingsTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "notificationSetting") as! NotificationSettingsTableViewController
            }
        }
        
        class var About: AboutTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "aboutPage") as! AboutTableViewController
            }
        }
        
        class var FluxList: FluxesListTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "fluxesList") as! FluxesListTableViewController
            }
        }
        
        class var NotificationList: NotificationListTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "NotificationViewController") as! NotificationListTableViewController
            }
        }
        
        class var TrendsList: TrendsListTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "TrendsViewController") as! TrendsListTableViewController
            }
        }
        
        class var PrivateMessageList: PrivateMessageListTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "privateMessageViewController") as! PrivateMessageListTableViewController
            }
        }
        
        class var CatDetail: CatArchiveDetailTableViewController {
            get {
                return Helper.Controller.instanceForStoryboardByName("Main", ForIdentifier: "catArchivePage") as! CatArchiveDetailTableViewController
            }
        }
        
        // display functions
        
        class func pushViewController(vc: UIViewController) {
            NSNotificationCenter.defaultCenter().postNotificationName(Constant.Notification.Helper.Controller.pushViewController, object: vc)
        }
        
    }
    
}