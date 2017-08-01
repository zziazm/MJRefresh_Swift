//
//  MJRefreshAutoNormalFooter.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/31.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshAutoNormalFooter: MJRefreshAutoStateFooter {
    var activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray{
        didSet{
            self.loadingView.activityIndicatorViewStyle = activityIndicatorViewStyle
            self.setNeedsLayout()
        }
    }
    
    lazy var loadingView: UIActivityIndicatorView = {
        let lv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        lv.hidesWhenStopped = true
        return lv
    }()
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        if self.loadingView.constraints.count > 0{
            return
        }
        
        var loadingCenterX = self.mj_width * 0.5
        if !self.refreshingTitleHidden {
            loadingCenterX -= self.stateLabel.mj_textWith() * 0.5 + labelLeftInset
            
        }
        
        let loadingCenterY = self.mj_height * 0.5
        
        self.loadingView.center = CGPoint(x: loadingCenterX, y: loadingCenterY)
    }
    
    override var state: MJRefreshState{
        didSet{
            if state == .noMoreData || state == .idle {
                self.loadingView.stopAnimating()
            }else if state == .refreshing {
                self.loadingView.startAnimating()
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
