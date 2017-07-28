//
//  MJRefreshBackStateFooter.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/28.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshBackStateFooter: MJRefreshBackFooter {
    
    lazy var stateTitles:[MJRefreshState:String] = [MJRefreshState:String]()
    
    lazy var stateLabel: UILabel = UILabel.mj_label()
    
    func set(title: String, state: MJRefreshState) -> Void {
        self.stateTitles[state] = title
        self.stateLabel.text = self.stateTitles[self.state]
    }
    
    var labelLeftInset: CGFloat = 0.0
    
    override func prepare() {
        super.prepare()
        self.addSubview(self.stateLabel)
        self.labelLeftInset = MJRefreshLabelLeftInset
        
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshBackFooterIdleText), state: .idle)
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshBackFooterPullingText), state: .pulling)
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshBackFooterRefreshingText), state: .refreshing)
        self.set(title: Bundle.mj_localizedStringForKey(key: MJRefreshBackFooterNoMoreDataText), state: .noMoreData)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.stateLabel.constraints.count > 0 {
            return
        }
        
        self.stateLabel.frame = self.bounds
    }
    
    override var state: MJRefreshState{
        didSet{
            self.stateLabel.text = self.stateTitles[state]
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
