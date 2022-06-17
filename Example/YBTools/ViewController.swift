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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.attributedText = label.yb_attribute(text: "请使用QQ手机版扫描二维码，\n安全登录，防止盗号。").yb_color(color: .blue, changeStr: "QQ手机版")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

