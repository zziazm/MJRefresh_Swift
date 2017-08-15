//
//  MJDIYHeader.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/27.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJDIYHeader: MJRefeshHeader {
    var label: UILabel = UILabel()
    var s: UISwitch = UISwitch()
    var logo: UIImageView = UIImageView(image:UIImage(named: "logo"))
    var loading: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func prepare() {
        super.prepare()
        self.mj_height = 50
        label.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        self.addSubview(label)
        
        self.addSubview(s)
        
        self.logo.contentMode = .scaleAspectFit
        self.addSubview(self.logo)
        
        self.addSubview(loading)
    }
    
    
    override func placeSubviews() {
        super.placeSubviews()
        self.label.frame = self.bounds
        self.logo.bounds = CGRect(x: 0, y: 0, width: self.mj_width, height: 100)
        
        self.logo.center = CGPoint(x: self.mj_width * 0.5, y: -self.logo.mj_height + 20)
        
        self.loading.center = CGPoint(x: self.mj_width - 30, y: self.mj_height * 0.5)
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                self.loading.stopAnimating()
                self.s.setOn(false, animated: true)
                self.label.text = "赶紧下拉吖(开关是打酱油滴)"
            case .pulling:
                self.loading.stopAnimating()
                self.s.setOn(true, animated: true)
                self.label.text = "赶紧放开我吧(开关是打酱油滴)"
            case .refreshing:
                self.s.setOn(true, animated: true)
                self.label.text = "加载数据中(开关是打酱油滴)"
                self.loading.startAnimating()
            default:
                break
            }
        }
    }
    
    override var pullingPercent: CGFloat{
        didSet{
            let red = 1.0 - pullingPercent * 0.5
            let green = 0.5 - 0.5 * pullingPercent
            let blue = 0.5 * pullingPercent
            
            self.label.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    
}
