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
        // user
        struct User {

            struct Name {
                struct Black {
                    static let font = Constant.Font.Regular.Size_22
                    static let color = Constant.Color.TextBlack
                }
                
                struct Blue {
                    static let font = Constant.Font.Regular.Size_22
                    static let color = Constant.Color.Theme
                }
            }
        }
        
        // number
        struct Number {
            struct Gray {
                static let font = Constant.Font.Regular.Size_22
                static let color = Constant.Color.TextGray
            }
            
            struct Blue {
                static let font = Constant.Font.Regular.Size_22
                static let color = Constant.Color.Theme
            }
            
            struct Small {
                struct Black {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.TextDeepGray
                }
            }
        }
        
        // ABC
        struct ABC {
            static let font = Constant.Font.Medium.Size_22
            static let color = Constant.Color.Theme
        }
        
        // button
        struct Button {
            struct White {
                static let font = Constant.Font.Regular.Size_22
                static let color = UIColor.whiteColor()
            }
            
            struct Blue {
                static let font = Constant.Font.Medium.Size_18
                static let color = Constant.Color.Theme
            }
            
            struct Black {
                static let font = Constant.Font.Regular.Size_18
                static let color = UIColor.blackColor()
            }
            
            struct Red {
                static let font = Constant.Font.Regular.Size_18
                static let color = Constant.Color.Pink
            }
        }
        
        // navigation
        struct Navigation {
            struct Title {
                static let font = Constant.Font.Semibold.Size_18
                static let color = Constant.Color.Theme
            }
            
            struct PrimaryButtonRight {
                struct Blue {
                    static let font = Constant.Font.Semibold.Size_17
                    static let color = Constant.Color.Theme
                }
                
                struct White {
                    static let font = Constant.Font.Semibold.Size_17
                    static let color = UIColor.whiteColor()
                }
                
                struct Gray {
                    static let font = Constant.Font.Semibold.Size_17
                    static let color = Constant.Color.TextGray
                }
            }
        }
        
        // alert
        struct Alert {
            struct Primary {
                static let font = Constant.Font.Medium.Size_17
                static let color = Constant.Color.Theme
            }
            
            struct Button {
                static let font = Constant.Font.Medium.Size_17
                static let color = Constant.Color.Theme
            }
            
            struct Title {
                static let font = Constant.Font.Medium.Size_17
                static let color = Constant.Color.TextBlack
            }
            
            struct Description {
                static let font = Constant.Font.Regular.Size_12
                static let color = Constant.Color.Theme
            }
        }
        
        // segmented control
        struct SegmentedControl {
            struct Tab {
                struct Active {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.TextDeepGray
                }
                
                struct Normal {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.TextGray
                }
                
                struct Blue {
                    static let font = Constant.Font.Regular.Size_13
                    static let color = Constant.Color.Theme
                }
                
                struct White {
                    static let font = Constant.Font.Regular.Size_13
                    static let color = UIColor.whiteColor()
                }
                
                struct Gray {
                    static let font = Constant.Font.Regular.Size_13
                    static let color = Constant.Color.TextMediumGray
                }
            }
            
            struct Selected {
                struct Blue {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.Theme
                }
                
                struct Gray {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.TextGray
                }
            }
        }
        
        // cell
        struct Cell {
            struct Title {
                struct White {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = UIColor.whiteColor()
                }
                
                struct Blue {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.Theme
                }
                
                struct Black {
                    static let font = Constant.Font.Regular.Size_16
                    static let color = Constant.Color.TextDeepGray
                }
                
                struct Gray {
                    static let font = Constant.Font.Regular.Size_13
                    static let color = Constant.Color.TextMediumGray
                }
            }
            
            struct Small {
                
                private static let font: UIFont = Constant.Font.Regular.Size_12
                
                struct Gray {
                    static let font = Cell.Small.font
                    static let color = Constant.Color.TextMediumGray
                }
                
                struct Blue {
                    static let font = Cell.Small.font
                    static let color = Constant.Color.Theme
                }
                
                struct White {
                    static let font = Cell.Small.font
                    static let color = Constant.Color.Theme
                }
            }
        }
        
        // body
        struct Body {
            struct Blue {
                static let font = Constant.Font.Regular.Size_14
                static let color = Constant.Color.Theme
            }
            
            struct Gray {
                static let font = Constant.Font.Regular.Size_14
                static let color = Constant.Color.TextMediumGray
            }
            
            struct White {
                static let font = Constant.Font.Regular.Size_14
                static let color = UIColor.whiteColor()
            }
            
            struct Black {
                static let font = Constant.Font.Regular.Size_14
                static let color = Constant.Color.TextDeepGray
            }
        }
        
        // placeholder
        struct Placeholder {
            static let font = Constant.Font.Regular.Size_13
            static let color = Constant.Color.TextGray
        }
        
        // tab bar
        struct TabBar {
            
            private static let font: UIFont = Constant.Font.Regular.Size_10
            
            struct Normal {
                static let font = TextStyle.TabBar.font
                static let color = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1)
            }
            
            struct Active {
                static let font = TextStyle.TabBar.font
                static let color = UIColor(red:0.56, green:0.56, blue:0.58, alpha:1)
            }
        }
    }
    
}
