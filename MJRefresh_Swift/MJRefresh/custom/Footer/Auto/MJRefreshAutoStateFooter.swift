//
//  MJRefreshAutoStateFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/31.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshAutoStateFooter: MJRefreshAutoFooter {

    lazy var stateTitles: [MJRefreshState:String] = [MJRefreshState:String]()
    lazy var stateLabel = UILabel.mj_label()
    
    func set(title: String, for state: MJRefreshState) -> Void {
        self.stateTitles[state] = title
        self.stateLabel.text = self.stateTitles[self.state]
    }
    
    func stateLabelClick() -> Void {
        if self.state == .idle{
            self.beginRefreshing()
        }
    }
    
    var labelLeftInset: CGFloat = MJRefreshLabelLeftInset
    override func prepare() {
        super.prepare()
        self.addSubview(self.stateLabel)
        
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshAutoFooterIdleText), for: .idle)
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshAutoFooterRefreshingText), for: .refreshing)
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshAutoFooterNoMoreDataText), for: .noMoreData)
        
        self.stateLabel.isUserInteractionEnabled = true
        self.stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.stateLabelClick)))
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.stateLabel.constraints.count > 0{
            return
        }
        self.stateLabel.frame = self.bounds
    }
    
    var refreshingTitleHidden = false
    override var state: MJRefreshState{
        didSet{
            if self.refreshingTitleHidden && self.state == .refreshing {
                self.stateLabel.text = nil
            }else{
                self.stateLabel.text = self.stateTitles[self.state]
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
