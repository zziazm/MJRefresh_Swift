//
//  MJDIYAutoFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJDIYAutoFooter: MJRefreshAutoFooter {
    
    lazy var label: UILabel = {
        let la = UILabel()
        la.textColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1)
        la.font = UIFont.systemFont(ofSize: 16)
        la.textAlignment = .center
        return la
    }()
    
    lazy var s: UISwitch = {
        let aSwitch = UISwitch()
        return aSwitch
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return load
    }()
    
    override func prepare() {
        super.prepare()
        self.mj_height = 50
        self.addSubview(self.label)
        self.addSubview(self.s)
        self.addSubview(self.loading)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.label.frame = self.bounds
        self.s.center = CGPoint(x: self.mj_width - 20, y: self.mj_height - 20)
        self.loading.center = CGPoint(x: 30, y: self.mj_height * 0.5)
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change: change)
    }
    
    override func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewPanStateDidChange(change: change)
    }
    
    override var state: MJRefreshState{
        didSet{
            switch state {
            case .idle:
                self.label.text = "赶紧上拉吖(开关是打酱油滴)"
                self.loading.stopAnimating()
                self.s.setOn(false, animated: true)
            case .refreshing:
                self.s.setOn(true, animated: true)
                self.label.text = "加载数据中(开关是打酱油滴)"
                self.loading.startAnimating()
            case .noMoreData:
                self.label.text = "木有数据了(开关是打酱油滴)"
                self.s.setOn(false, animated: true)
                self.loading.stopAnimating()
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
