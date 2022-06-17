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
    func getWidth(font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: 20.0)
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
        return labelSize.width
    }
    
    func getHeight(font: UIFont,width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: attributes, context: nil).size
        return labelSize.height
    }
    
    func joinHtml() -> String {
        return "<!DOCTYPE html><html lang=\"zh-CN\"><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\"><style>body{padding:0;margin:0;}img{display:block;width:100%;}</style></head><body>\(self)</body></html>"
    }
    
}
