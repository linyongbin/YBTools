//
//  UILabel+YBTools.swift
//  YBTools
//
//  Created by 林勇彬 on 2022/6/17.
//

import Foundation

public extension UILabel {
    
    @discardableResult func yb_text(text:String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult func yb_color(color:UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult func yb_font(font:CGFloat) -> Self {
        self.font = UIFont.systemFont(ofSize: font)
        return self
    }
    
    @discardableResult func yb_blodFont(blodFont:CGFloat) -> Self {
        self.font = UIFont.boldSystemFont(ofSize: blodFont)
        return self
    }
    
    @discardableResult func yb_alignment(alignment:NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
}
