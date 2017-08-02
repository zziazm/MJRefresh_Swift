//
//  MJDIYBackFooter.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJDIYBackFooter: MJRefreshBackFooter {
    
    lazy var label: UILabel = {
        let la = UILabel()
        la.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        la.font = UIFont.systemFont(ofSize: 16)
        la.textAlignment = .center
        return la
    }()
    
    lazy var s: UISwitch = {
        let aSwitch = UISwitch()
        return aSwitch
    }()
    
    lazy var logo: UIImageView = {
        let iv = UIImageView(image:UIImage(named: "Logo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return load
    }()
    
    
    override func prepare() {
        super.prepare()
        self.addSubview(label)
        self.addSubview(s)
        self.addSubview(loading)
        self.addSubview(self.logo)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.label.frame = self.bounds
        self.logo.bounds = CGRect(x: 0, y: 0, width: self.mj_width, height: 100)
        self.logo.center = CGPoint(x: self.mj_width * 0.5, y: self.mj_height + self.logo.mj_height + 0.5)
        
        self.loading.center = CGPoint(x: self.mj_width - 30, y: self.mj_height * 0.5)
        
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                self.loading.stopAnimating()
                self.s.setOn(false, animated: true)
                self.label.text = "赶紧上拉吖(开关是打酱油滴)"
            case .pulling:
                self.loading.stopAnimating()
                self.s.setOn(true, animated: true)
                self.label.text = "赶紧放开我吧(开关是打酱油滴)"
            case .refreshing:
                self.loading.startAnimating()
                self.s.setOn(true, animated: true)
                self.label.text = "加载数据中(开关是打酱油滴)"
            case .noMoreData:
                self.loading.stopAnimating()
                self.label.text = "木有数据了(开关是打酱油滴)"
                self.s.setOn(false, animated: true)
            default:
                break
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
