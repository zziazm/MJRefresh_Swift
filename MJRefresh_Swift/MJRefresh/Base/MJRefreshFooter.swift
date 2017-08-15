//
//  MJRefreshFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/27.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshFooter: MJRefreshComponent {
    //忽略多少scrollView的contentInset的bottom
    var ignoredScrollViewContentInsetBottom: CGFloat = 0.0
    
    init(refreshingBlock: @escaping MJRefreshComponentRefreshingBlock) {
        super.init(frame: CGRect.zero)
        self.refreshingBlock = refreshingBlock
    }
    
    init(refreshingTarget target: Any?, refreshingAction action: Selector) {
        super.init(frame: CGRect.zero)
        self.set(refreshingTarget: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var automaticallyHidden = false
    override func prepare() {
        super.prepare()
        self.mj_height = MJRefreshFooterHeight
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            if self.scrollView is UITableView || self.scrollView is UICollectionView {
                self.scrollView?.mj_reloadDataBlock = { (totalDataCount: Int) in
                    if self.automaticallyHidden {
                        self.isHidden = (totalDataCount == 0)
                    }
                    
                }
            }
        }
    }
    
    func endRefreshingWithNoMoreData() -> Void {
        self.state = .noMoreData
    }
    
    func noticeNoMoreData() -> Void {
        self.endRefreshingWithNoMoreData()
    }
    
    func resetNoMoreData() -> Void {
        self.state = .idle
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
