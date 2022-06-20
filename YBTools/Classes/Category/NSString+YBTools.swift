//
//  NSString+Handle.swift
//  MinaTicket
//
//  Created by 林勇彬 on 2022/5/29.
//  Copyright © 2022 Hola. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    func yb_getWidth(font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: 20.0)
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
        return labelSize.width
    }
    
    func yb_getHeight(font: UIFont,width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
        return labelSize.height
    }
    
    func yb_joinHtml() -> String {
        return "<!DOCTYPE html><html lang=\"zh-CN\"><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\"><style>body{padding:0;margin:0;}img{display:block;width:100%;}</style></head><body>\(self)</body></html>"
    }
    
}

//MARK: 正则表达式
public extension String {
    /**#pragma mark -- 金额
     + (BOOL)moneyPredicateWithMoney:(NSString *)target{
         NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数
         return [[self class] regexPatternResultWithRegex:regex TargetString:target];
     }*/
    
    /// 判断该字符串是不是金额
    /// - Returns: true or false
    func isMoney() -> Bool {
        //一般格式 d{0,8} 控制位数
        let regex = "(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?"
        return self.regexPattern(regex: regex, target: self)
    }
    
    func regexPattern(regex: String,target: String) -> Bool {
        if target.isEmpty { return true }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: target)
    }
}
