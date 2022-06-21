//
//  ViewController.swift
//  YBTools
//
//  Created by 林勇彬 on 06/17/2022.
//  Copyright (c) 2022 林勇彬. All rights reserved.
//

import UIKit
import YBTools

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topView: UIView!
    lazy var cell = UICollectionViewCell(frame: CGRect(x: 50, y: 300, width: 50, height: 50))
    
    @IBOutlet weak var button: UIButton!
    
    lazy var textView: YBTextView = {
        let view = YBTextView.init(frame: CGRect(x: 10, y: 50, width: 100, height: 100))
        view.placeholder = "请输入你想写的内容"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.attributedText = label.yb_attribute(text: "请使用QQ手机版扫描二维码，\n安全登录，防止盗号。").yb_color(color: UIColor.yb_hex(hex: "0xef65ab"), changeStr: "QQ手机版").yb_color(color: UIColor.yb_hex(hex: 0xef65ab), changeStr: "二维码").yb_strikethrough(changeStr: "防止盗号").yb_color(color: UIColor.gray)
//        label.yb_border(borderWidth: 1, borderColor: .red, direction: .all)
//        label.cornerRadius(cornerRadii: 10, corner: .topLeft)
        
//        label.clipsToBounds = true
//        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        
//        topView.backgroundColor = .red
//        topView.cornerRadiusBorder(radius: 30, corners: .allCorners, color: .blue, lineWidth: 1)
//        topView.yb_cornerRadius(cornerRadii: 10, corner: .allCorners)
//        topView.yb_shadow(shadowColor: .black, shadowOffset: CGSize(width: 10,height: 10), shadowRadius: 10, shadowOpacity: 0.5)
        
        topView.yb_backgroundGradient(type: .TopToBottom, colors: [UIColor.yb_hex(hex: "#ffffff"),UIColor.yb_hex(hex: 0xF3EBFF)])
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.yb_backgroundGradient(type: .TopToBottom, colors: [UIColor.yb_hex(hex: "#afeff6"),UIColor.yb_hex(hex: 0xF3EBFF)])
        view.addSubview(textView)
        
        print("MD5加密:" + "123456".yb_encryptMD5)
        let str = "qwerty123456"
        let base64Str = str.yb_base64Encrypt
        print("base64加密：" + base64Str)
        print("base64解密：" + base64Str.yb_base64Decrypt)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

