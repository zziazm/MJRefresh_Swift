//
//  MJRefreshAutoFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/28.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshAutoFooter: MJRefreshFooter {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil{
            if let scrollView = self.scrollView {
                if self.isHidden == false {
                    scrollView.mj_insetBottom += self.mj_height
                }
                
                self.mj_y = scrollView.mj_contentHeight
            }
            
        }else{
            if self.isHidden == false {
                if let scrollView = self.scrollView {
                    scrollView.mj_insetBottom -= self.mj_height
                }
            }
        }
    }
    
    //当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新)
    var triggerAutomaticallyRefreshPercent: CGFloat = 1.0
    
    // 是否自动刷新(默认为true)
    var automaticallyRefresh: Bool = true
    
    override func prepare() {
        super.prepare()
    
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change: change)
        if let scrollView = self.scrollView{
            self.mj_y = scrollView.mj_contentHeight
        }
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
        if self.state != .idle || !self.automaticallyRefresh || self.mj_y == 0 {
            return
        }
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        if scrollView.mj_insetTop + scrollView.mj_contentHeight > scrollView.mj_height {
            if  scrollView.mj_offsetY >= scrollView.mj_contentHeight - scrollView.mj_height + self.mj_height * triggerAutomaticallyRefreshPercent + scrollView.mj_insetBottom - self.mj_height {
                if let tChange = change {
                    let old = tChange[NSKeyValueChangeKey.oldKey] as! CGPoint
                    let new = tChange[NSKeyValueChangeKey.newKey] as! CGPoint
                    
                    if new.y < old.y {
                        return
                    }
                }
                self.beginRefreshing()
                
            }
        }
    }
    
    override func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewPanStateDidChange(change: change)
        
        if self.state != .idle{
            return
        }
        
        guard let scrollView = self.scrollView else {
            return
        }
        
        if scrollView.panGestureRecognizer.state == .ended{
            if scrollView.mj_insetTop + scrollView.mj_contentHeight <= scrollView.mj_contentHeight {
                if scrollView.mj_offsetY >= -scrollView.mj_insetTop {
                    self.beginRefreshing()
                }
            }else {
                if scrollView.mj_offsetY >= scrollView.mj_contentHeight  + scrollView.mj_insetBottom - scrollView.mj_height {
                    self.beginRefreshing()
                }
            }
        }
    }
    
    
    override var state: MJRefreshState{
        didSet{
            if state == .refreshing{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: { 
                    self.executeRefreshingCallback()
                })
            }else if state == .noMoreData || state == .idle{
                if oldValue == .refreshing {
                    if let endRefreshingCompletionBlock = self.endRefreshingCompletionBlock{
                        endRefreshingCompletionBlock()
                    }
                }
            }
        }
    }
    
    
    override var isHidden: Bool{
        didSet{
            if !oldValue && isHidden {
                self.state = .idle
                self.scrollView?.mj_insetBottom -= self.mj_height
            } else if oldValue && !isHidden{
                self.scrollView?.mj_insetBottom += self.mj_height
                self.mj_y = (self.scrollView?.mj_contentHeight)!
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
