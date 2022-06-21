//
//  UIViewController+YBTools.swift
//  YBTools
//
//  Created by 林勇彬 on 2022/6/21.
//

import Foundation

extension UIViewController {
    
    /// 返回指定的控制器
    /// - Parameter vcType: 控制器类型
    /// - Returns: 是否返回成功
    func yb_popToViewController(vcType:AnyClass) -> Bool {
        guard let childrens = self.navigationController?.children else { return false }
        for thisVC in childrens {
            if thisVC.isKind(of: vcType) {
                self.navigationController?.popToViewController(thisVC, animated: true)
                return true
            }
        }
        return false
    }
    
}
