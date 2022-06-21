//
//  YBAttributedStringTools.swift
//  MinaTicket
//
//  Created by 林勇彬 on 2022/6/8.
//  Copyright © 2022 Hola. All rights reserved.
//

import Foundation

/// 当前的Window
public var yb_currentWindow:UIWindow? {
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = scene as? UIWindowScene else { return nil }
        guard let window = windowScene.windows.first else { return nil }
        return window
    } else {
        guard let window = UIApplication.shared.windows.first else { return nil }
        return window
    }
}
/// 当前的控制器
public var yb_currentVC: UIViewController? {
    var current = yb_currentWindow?.rootViewController
    
    while (current?.presentedViewController != nil)  {
        current = current?.presentedViewController
    }
    
    if let tabbar = current as? UITabBarController , tabbar.selectedViewController != nil {
        current = tabbar.selectedViewController
    }
    
    while let navi = current as? UINavigationController , navi.topViewController != nil  {
        current = navi.topViewController
    }
    return current
}

/// 判断该手机是否有刘海
private var isiPhoneX: Bool {
    if #available(iOS 11, *) {
        guard let unwrapedWindow = yb_currentWindow else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            return true
        }
    }
    return false
}

// MARK: - app设备各种数值

/*! @brief 当前屏幕宽度
 */
public let ybScreenWidth = UIScreen.main.bounds.size.width
/*! @brief 当前屏幕高度
 */
public let ybScreenHeight = UIScreen.main.bounds.size.height
/*! @brief 当前屏幕Bounds
 */
public let ybScreenBounds = UIScreen.main.bounds
/*! @brief 当前屏幕Size
 */
public let ybScreenSize = ybScreenBounds.size
/*! @brief 当前屏幕比例
 */
public let ybScreenScale = UIScreen.main.scale

/// 导航栏高度，不包括状态栏
public let ybNavBarHeightNotIncludeStatusBar : CGFloat = 44
/// 状态栏默认高度
public var ybStatusBarHeight: CGFloat {
    if #available(iOS 13, *) {
        return yb_currentWindow?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 20
    }else {
        return UIApplication.shared.statusBarFrame.height
    }
}
/// 导航栏+状态栏的高度
public let ybNavBarHeight: CGFloat = ybNavBarHeightNotIncludeStatusBar + ybStatusBarHeight

/// APP主页Tabbar的高度
public let ybTabbarHeight : CGFloat = 49

/// 底部安全区域
public let ybSafetyAreaBottomHeight : CGFloat = yb_currentWindow?.safeAreaInsets.bottom ?? 0

/// 底部安全区域+Tabbar的高度
public let ybTabbarHeight_Total : CGFloat = ybTabbarHeight + ybSafetyAreaBottomHeight

// MARK: - app版本&设备系统版本
public let infoDictionary            = Bundle.main.infoDictionary
/* App名称 */
public let ybAppName: String?         = infoDictionary!["CFBundleDisplayName"] as? String
/* App版本号 */
public let ybAppVersion: String?      = infoDictionary!["CFBundleShortVersionString"] as? String
/* Appbuild版本号 */
public let ybAppBuildVersion: String? = infoDictionary!["CFBundleVersion"] as? String
/* app bundleId */
public let ybAppBundleId: String?     = infoDictionary!["CFBundleIdentifier"] as? String
/* 平台名称（iphonesimulator 、 iphone）*/
public let ybPlatformName: String?    = infoDictionary!["DTPlatformName"] as? String
/* iOS系统版本 */
public let ybiOSVersion: String       = UIDevice.current.systemVersion
/* 系统名称+版本，e.g. @"iOS 12.1" */
public let ybOSType: String           = UIDevice.current.systemName + UIDevice.current.systemVersion

