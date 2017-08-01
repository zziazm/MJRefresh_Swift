//
//  MJRefreshBackFooter.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/27.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshBackFooter: MJRefreshFooter {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.scrollViewContentSizeDidChange(change: nil)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
        
        if self.state == .refreshing  {
            return
        }
        if let contentInset = self.scrollView?.contentInset{
            self.scrollViewOriginalInset = contentInset
        }
        if let scrollView = self.scrollView {
            let currentOffsetY = scrollView.mj_offsetY
            let happenOffsetY = self.happenOffsetY()
            
            if currentOffsetY < happenOffsetY{
                return
            }
            
            let pullingPercent = (currentOffsetY - happenOffsetY) / self.mj_height
            
            if self.state == .noMoreData {
                self.pullingPercent = pullingPercent
                return
            }
            
            if scrollView.isDragging {
                self.pullingPercent = pullingPercent
                
                let normal2pullingOffsetY = happenOffsetY + self.mj_height
                if self.state == .idle && currentOffsetY > normal2pullingOffsetY {
                    self.state = .pulling
                }else if self.state == .pulling && currentOffsetY <= normal2pullingOffsetY  {
                    self.state = .idle
                }
            }else if self.state == .pulling{
                self.beginRefreshing()
            }else if pullingPercent < 1{
                self.pullingPercent = pullingPercent
            }
        }
    }
    
    func happenOffsetY() -> CGFloat {
       let deltaH = self.heightForContentBreakView()
        if deltaH > 0{
            return deltaH - self.scrollViewOriginalInset.top
        }else{
            return -self.scrollViewOriginalInset.top
        }
    }
    
    func heightForContentBreakView() -> CGFloat {
        if let scrollView = self.scrollView {
          let h = scrollView.mj_height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top
          return scrollView.contentSize.height - h
        }else{
            return 0.0
        }
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change: change)
        if let scrollView = self.scrollView {
            let contentHeight = scrollView.mj_contentHeight + self.ignoredScrollViewContentInsetBottom
            let scrollHeight = scrollView.mj_height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom
            self.mj_y = max(contentHeight, scrollHeight)
        }
    }
    
    var lastBottomDelta: CGFloat = 0.0
    var lastRefreshCount: Int = 0
    override var state: MJRefreshState{
        didSet{
            guard let scrollView = self.scrollView else {
                return
            }
            
            if state == .noMoreData || state == .idle {
                if oldValue == .refreshing{
                    UIView.animate(withDuration: MJRefreshSlowAnimationDuration, animations: { 
                        scrollView.mj_insetBottom -= self.lastBottomDelta
                        if self.autoChangeAlpha {
                            self.alpha = 0.0
                        }
                    }, completion: { (finished) in
                        self.pullingPercent = 0.0
                        
                        if let endRefreshingCompletionBlock = self.endRefreshingCompletionBlock {
                            endRefreshingCompletionBlock()
                        }
                    })
                }
                
                let deltaH: CGFloat = self.heightForContentBreakView()
                if oldValue == .refreshing && deltaH > 0 && scrollView.mj_totalDataCount != self.lastRefreshCount {
                    let tem = scrollView.mj_offsetY
                    scrollView.mj_offsetY = tem
                }
            } else if state == .refreshing {
                self.lastRefreshCount = scrollView.mj_totalDataCount
                UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                    var bottom = self.mj_height + self.scrollViewOriginalInset.bottom
                    let deltaH = self.heightForContentBreakView()
                    if deltaH < bottom  {
                        bottom = bottom - deltaH
                    }
                    
                    self.lastBottomDelta = bottom - scrollView.mj_insetBottom
                    scrollView.mj_insetBottom = bottom
                    scrollView.mj_offsetY = self.happenOffsetY() + self.mj_height
                    
                }, completion: { (finished) in
                    self.executeRefreshingCallback()
                })
            }
        }
    }
    
    
    override func endRefreshing() {
        DispatchQueue.main.async {
            self.state = .idle
        }
    }
    
    override func endRefreshingWithNoMoreData() {
        DispatchQueue.main.async {
            self.state = .noMoreData
        }
    }
    
    

}
