//
//  Constant.swift
//  NearCat
//
//  Created by huchunbo on 15/12/26.
//  Copyright © 2015年 Bijiabo. All rights reserved.
//

import Foundation
import UIKit

public struct Constant {
    
    static let iOS_9: Bool = NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 9, minorVersion: 0, patchVersion: 0))

    struct Notification {
        struct Alert {
            static let Dictionary: [String: String] = [
                "showLoginTextField": "Alert_ShowLoginTextField",
                "showRegisterTextField": "Alert_ShowRegisterTextField",
                "showLoading": "Alert_ShowLoading",
                "hideLoading": "Alert_HideLoading",
                "showError": "Alert_showError"
            ]
            
            static let showLoginTextField = Dictionary["showLoginTextField"]!
            static let showRegisterTextField = Dictionary["showRegisterTextField"]!
            static let showLoading = Dictionary["showLoading"]!
            static let hideLoading = Dictionary["hideLoading"]!
            static let showError = Dictionary["showError"]!
        }
        
        struct Location {
            static let didUpdate = "Location_didUpdate"
        }
    }
    
    struct Color {
        static let Theme: UIColor = UIColor(red:0.36, green:0.5, blue:0.66, alpha:1)
        static let CellSelected: UIColor = UIColor(red:0.36, green:0.5, blue:0.66, alpha:0.1)
        static let Pink: UIColor = UIColor(red:1, green:0.35, blue:0.43, alpha:1)
        static let TextBlack: UIColor = UIColor(red:0.01, green:0.01, blue:0.01, alpha:1)
        static let TextGray: UIColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1)
        static let TextDeepGray: UIColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1)
        static let TextMediumGray: UIColor = UIColor(red:0.51, green:0.51, blue:0.51, alpha:1)
    }
    
    struct Font {
        struct Name {
            static let Regular = iOS_9 ? "PingFangSC-Regular" : "STHeitiSC-Light"
            static let Medium = iOS_9 ? "PingFangSC-Medium" : "STHeitiSC-Medium"
            static let Semibold = iOS_9 ? "PingFangSC-Semibold" : "STHeitiSC-Medium"
        }
        
        struct Regular {
            
            static func fontForSize(size: CGFloat) -> UIFont {
                return UIFont(name: Constant.Font.Name.Regular, size: size)!
            }

            static let Size_10: UIFont = Font.Regular.fontForSize(10.0)
            static let Size_13: UIFont = Font.Regular.fontForSize(13.0)
            static let Size_14: UIFont = Font.Regular.fontForSize(14.0)
            static let Size_12: UIFont = Font.Regular.fontForSize(12.0)
            static let Size_16: UIFont = Font.Regular.fontForSize(16.0)
            static let Size_18: UIFont = Font.Regular.fontForSize(18.0)
            static let Size_22: UIFont = Font.Regular.fontForSize(22.0)
        }
        
        struct Medium {
            static func fontForSize(size: CGFloat) -> UIFont {
                return UIFont(name: Constant.Font.Name.Medium, size: size)!
            }
            
            static let Size_17: UIFont = Font.Medium.fontForSize(17.0)
            static let Size_18: UIFont = Font.Medium.fontForSize(18.0)
            static let Size_22: UIFont = Font.Medium.fontForSize(22.0)
        }
        
        struct Semibold {
            static func fontForSize(size: CGFloat) -> UIFont {
                return UIFont(name: Constant.Font.Name.Semibold, size: size)!
            }
            
            static let Size_17: UIFont = Font.Semibold.fontForSize(17.0)
            static let Size_18: UIFont = Font.Semibold.fontForSize(18.0)
        }
    }
    
    struct FontName {
        struct PingFangSC {
            static let Regular = "PingFangSC-Regular"
            static let Medium = "PingFangSC-Medium"
            static let Semibold = "PingFangSC-Semibold"
        }
    }
    
    struct TextStyle {
        
        struct instance {
            
            init(font: UIFont, color: UIColor) {
                self.font = font
                self.color = color
            }
            
            var font = Constant.Font.Regular.Size_22
            var color = Constant.Color.TextBlack
        }
        
        typealias type = instance
        
        // user
        struct User {

            struct Name {
                static let Black = TextStyle.instance(font: Constant.Font.Regular.Size_22, color: Constant.Color.TextBlack)
                
                static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_22, color: Constant.Color.Theme)
            }
        }
        
        // number
        struct Number {
            static let Gray = TextStyle.instance(font: Constant.Font.Regular.Size_22, color: Constant.Color.TextGray)
            static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_22, color: Constant.Color.Theme)
            
            struct Small {
                static let Black = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextDeepGray)
            }
        }
        
        // ABC
        static let ABC = TextStyle.instance(font: Constant.Font.Medium.Size_22, color: Constant.Color.Theme)
        
        // button
        struct Button {
            static let White = TextStyle.instance(font: Constant.Font.Regular.Size_22, color: UIColor.whiteColor())
            static let Blue = TextStyle.instance(font: Constant.Font.Medium.Size_18, color: Constant.Color.Theme)
            static let Black = TextStyle.instance(font: Constant.Font.Regular.Size_18, color: UIColor.blackColor())
            static let Red = TextStyle.instance(font: Constant.Font.Regular.Size_18, color: Constant.Color.Pink)
        }
        
        // navigation
        struct Navigation {
            static let Title = TextStyle.instance(font: Constant.Font.Semibold.Size_18, color: Constant.Color.Theme)
            
            struct PrimaryButtonRight {
                static let Blue = TextStyle.instance(font: Constant.Font.Semibold.Size_17, color: Constant.Color.Theme)
                static let White = TextStyle.instance(font: Constant.Font.Semibold.Size_17, color: UIColor.whiteColor())
                static let Gray = TextStyle.instance(font: Constant.Font.Semibold.Size_17, color: Constant.Color.TextGray)
            }
        }
        
        // alert
        struct Alert {
            static let Primary = TextStyle.instance(font: Constant.Font.Medium.Size_17, color: Constant.Color.Theme)
            static let Button = TextStyle.instance(font: Constant.Font.Medium.Size_17, color: Constant.Color.Theme)
            static let Title = TextStyle.instance(font: Constant.Font.Medium.Size_17, color: Constant.Color.TextBlack)
            static let Description = TextStyle.instance(font: Constant.Font.Regular.Size_12, color: Constant.Color.Theme)
        }
        
        // segmented control
        struct SegmentedControl {
            struct Tab {
                static let Active = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextDeepGray)
                static let Normal = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextGray)
                static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_13, color: Constant.Color.Theme)
                static let White = TextStyle.instance(font: Constant.Font.Regular.Size_13, color: UIColor.whiteColor())
                static let Gray = TextStyle.instance(font: Constant.Font.Regular.Size_13, color: Constant.Color.TextMediumGray)
            }
            
            struct Selected {
                static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.Theme)
                static let Gray = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextGray)
            }
        }
        
        // cell
        struct Cell {
            struct Title {
                static let White = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: UIColor.whiteColor())
                static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextGray)
                static let Black = TextStyle.instance(font: Constant.Font.Regular.Size_16, color: Constant.Color.TextDeepGray)
                static let Gray = TextStyle.instance(font: Constant.Font.Regular.Size_13, color: Constant.Color.TextMediumGray)
            }
            
            struct Small {
                
                private static let font: UIFont = Constant.Font.Regular.Size_12
                
                static let White = TextStyle.instance(font: Cell.Small.font, color: UIColor.whiteColor())
                static let Blue = TextStyle.instance(font: Cell.Small.font, color: Constant.Color.Theme)
                static let Gray = TextStyle.instance(font: Cell.Small.font, color: Constant.Color.TextMediumGray)
            }
        }
        
        // body
        struct Body {
            
            static let Blue = TextStyle.instance(font: Constant.Font.Regular.Size_14, color: Constant.Color.Theme)
            static let Gray = TextStyle.instance(font: Constant.Font.Regular.Size_14, color: Constant.Color.TextMediumGray)
            static let White = TextStyle.instance(font: Constant.Font.Regular.Size_14, color: UIColor.whiteColor())
            static let Black = TextStyle.instance(font: Constant.Font.Regular.Size_14, color: Constant.Color.TextDeepGray)
        }
        
        // placeholder
        static let Placeholder = TextStyle.instance(font: Constant.Font.Regular.Size_13, color: Constant.Color.TextGray)
        
        // tab bar
        struct TabBar {
            private static let font: UIFont = Constant.Font.Regular.Size_10
            
            static let Normal = TextStyle.instance(font: TextStyle.TabBar.font, color: UIColor(red:0.56, green:0.56, blue:0.58, alpha:1))
            static let Active = TextStyle.instance(font: TextStyle.TabBar.font, color: UIColor(red:0.56, green:0.56, blue:0.58, alpha:1))
        }
    }
    
}
