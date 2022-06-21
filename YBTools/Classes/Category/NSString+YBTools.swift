//
//  NSString+Handle.swift
//  MinaTicket
//
//  Created by 林勇彬 on 2022/5/29.
//  Copyright © 2022 Hola. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

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

//MARK: 加密
public extension String {
    
    /// MD5加密
    var yb_encryptMD5: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// Base64加密
    var yb_base64Encrypt: String {
        return self.data(using: .utf8)?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters) ?? ""
    }
    
    /// Base64解密
    var yb_base64Decrypt: String {
        let strData = NSData.init(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        guard let data = strData as? Data else { return "" }
        return String.init(data: data, encoding: .utf8) ?? ""
    }
}
