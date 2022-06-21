//
//  UIColor+YBTools.swift
//  YBTools
//
//  Created by 林勇彬 on 2022/6/17.
//

import Foundation

public extension UIColor {
    
    
    /// 16进制数转化成颜色，传字符串
    /// - Parameters:
    ///   - hex: hex值
    ///   - alpha: 透明度
    /// - Returns: 返回颜色
    class func yb_hex(hex: String,alpha:CGFloat = 1) -> UIColor{
        let tempStr = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let scanner = Scanner(string: tempStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        var hexint : UInt32 = 0
        scanner.scanHexInt32(&hexint)
        
        let color = UIColor(red: ((CGFloat) ((hexint & 0xFF0000) >> 16))/255, green: ((CGFloat) ((hexint & 0xFF00) >> 8))/255, blue: ((CGFloat) (hexint & 0xFF))/255, alpha: alpha)
        return color
    }
    
    /// 16进制数转化成颜色，传16进制数
    /// - Parameters:
    ///   - hex: hex值
    ///   - alpha: 透明度
    /// - Returns: 返回颜色
    class func yb_hex(hex: Int,alpha:CGFloat = 1) -> UIColor {
        if !(0...0xFFFFFF ~= hex) {
            return UIColor.white
        }
        let red:CGFloat = CGFloat((hex & 0xFF0000) >> 16)
        let green:CGFloat = CGFloat((hex & 0x00FF00) >> 8)
        let blue:CGFloat = CGFloat((hex & 0x0000FF))
        let color = UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
        return color
    }
    
    /// 随机颜色
    static var yb_random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)

        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
    
    @available(iOS 13.0, tvOS 13.0, *)
    convenience init(light: UIColor, dark: UIColor) {
        self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
    }
    
}
