//
//  UIView+YBTools.swift
//  YBTools
//
//  Created by 林勇彬 on 2022/6/18.
//

import Foundation

//MARK: 获取View的基本信息
extension UIView {
    
    @objc public var yb_X: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    @objc public var yb_Y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    @objc public var yb_Width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    @objc public var yb_Height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    @objc public var yb_maxX: CGFloat{
        get{
            yb_X + yb_Width
        }
        set{
            yb_X = newValue - yb_Width
        }
    }
    @objc public var yb_maxY: CGFloat{
        get{
            yb_Y + yb_Height
        }
        set{
            yb_Y = newValue - yb_Height
        }
    }
    
    @objc public var yb_centerX: CGFloat{
        get{
            yb_Width * 0.5
        }
        set{
            center.x = newValue
        }
    }
    
    @objc public var yb_centerY: CGFloat{
        get{
            yb_Height * 0.5
        }
        set{
            center.y = newValue
        }
    }
}

//MARK: 边框圆角
extension UIView {
    
    /// 圆角优化 离屏渲染优化方案
    /// 无法添加阴影效果，阴影会被剪切掉
    /// - Parameters:
    ///   - cornerRadii: 圆角半径
    ///   - corner: 方向
    /// - Returns: 贝塞尔曲线
    @objc public func yb_cornerRadius(cornerRadii:CGFloat,corner:UIRectCorner) {
        self.layoutIfNeeded()
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize.init(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    ///使用CALayer画边框（使用该方法，不能设置圆角）
    /// - Parameters:
    ///   - borderWidth: 宽度
    ///   - borderColor: 颜色
    ///   - direction: 方向
    @objc public func yb_border(borderWidth:CGFloat,borderColor:UIColor,direction:UIRectEdge) {
        self.layoutIfNeeded()
        
        if direction.contains(.all)  {
            self.cornerRadiusBorder(radius: 0, corners: .allCorners, color: borderColor, lineWidth: borderWidth)
            return
        }
        if direction.contains(.top) {
            let bounds = CALayer();
            bounds.frame = CGRect(x: 0, y: 0, width: self.yb_Width, height: borderWidth)
            bounds.backgroundColor = borderColor.cgColor;
            self.layer.addSublayer(bounds)
        }
        if direction.contains(.left) {
            let bounds = CALayer();
            bounds.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.yb_Height)
            bounds.backgroundColor = borderColor.cgColor;
            self.layer.addSublayer(bounds)
        }
        if direction.contains(.bottom) {
            let bounds = CALayer();
            bounds.frame = CGRect(x: 0, y: self.yb_Height - borderWidth, width: self.yb_Width, height: borderWidth)
            bounds.backgroundColor = borderColor.cgColor;
            self.layer.addSublayer(bounds)
        }
        if direction.contains(.right) {
            let bounds = CALayer();
            bounds.frame = CGRect(x: self.yb_Width - borderWidth, y: 0, width: borderWidth, height: self.yb_Height)
            bounds.backgroundColor = borderColor.cgColor;
            self.layer.addSublayer(bounds)
        }
    }
    
    /// 圆角边框优化 离屏渲染优化方案(使用条件，view的背景颜色必须是透明)
    /// 可以配合‘yb_shadow’方法，添加阴影效果
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - corners: 圆角方向
    ///   - color: 边框颜色
    ///   - lineWidth: 边框宽度
    @objc public func cornerRadiusBorder(radius: CGFloat, corners: UIRectCorner, color: UIColor, lineWidth: CGFloat) {
        self.layoutIfNeeded()
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        // 添加border
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        // 设置圆角路径
        borderLayer.path = maskPath.cgPath
        // 设置边框宽度
        borderLayer.lineWidth = lineWidth
        // 设置边框颜色
        borderLayer.strokeColor = color.cgColor
        // 填充颜色默认为黑色，把颜色clear掉
        borderLayer.fillColor = UIColor.clear.cgColor
        if let layers: NSArray = self.layer.sublayers as? NSArray {
            if let last = layers.lastObject as? AnyObject {
                if last.isKind(of: CAShapeLayer.self) {
                    last.removeFromSuperlayer()
                }
            }
        }
        
        self.layer.addSublayer(borderLayer)
    }
    
    /// 添加阴影效果
    /// - Parameters:
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 阴影偏移量
    ///   - shadowRadius: 阴影半径
    ///   - shadowOpacity: 阴影透明度
    @objc public func yb_shadow(shadowColor: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float ) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
    
    @objc public func yb_shadowDefault(shadowColor: UIColor) {
        self.yb_shadow(shadowColor: shadowColor, shadowOffset: CGSize(width: 5, height: 5), shadowRadius: 5, shadowOpacity: 0.5)
    }
}


//MARK: 其他
extension UIView {
    
    @objc public enum GradienDirectionType:Int
    {
        case LeftToRight
        case TopToBottom
        case RightToLeft
        case BottomToTop
    }
    
    //MARK: View的背景渐变
    @objc public func yb_backgroundGradient(type:GradienDirectionType,colors:[UIColor])
    {
        self.backgroundColor = .clear
        let maskLayer = CAGradientLayer()
        
        var cgColorsss = [CGColor]()
        colors.enumerated().forEach { (index,value) in
            cgColorsss.append(value.cgColor)
        }
        
        maskLayer.colors = cgColorsss
        switch type {
        case .LeftToRight:
            maskLayer.startPoint = CGPoint.init(x: 0, y: 0)
            maskLayer.endPoint = CGPoint.init(x: 1, y: 0)
        case .TopToBottom:
            maskLayer.startPoint = CGPoint.init(x: 0, y: 0)
            maskLayer.endPoint = CGPoint.init(x: 0, y: 1)
        case .RightToLeft:
            maskLayer.startPoint = CGPoint.init(x: 1, y: 0)
            maskLayer.endPoint = CGPoint.init(x: 0, y: 0)
        case .BottomToTop:
            maskLayer.startPoint = CGPoint.init(x: 0, y: 1)
            maskLayer.endPoint = CGPoint.init(x: 0, y: 0)
        }
        maskLayer.frame = self.bounds
        self.layer.addSublayer(maskLayer)
        self.layer.insertSublayer(maskLayer, at: 0)
        self.setNeedsDisplay()
    }
    
}
