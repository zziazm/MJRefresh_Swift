//
//  MJRefeshHeader.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/7/19.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit
class MJRefeshHeader: MJRefreshComponent {
 
    
    
    
    
    
//    static func header(refreshingBlock: @escaping MJRefreshComponentRefreshingBlock) -> MJRefeshHeader{
//        let cmp = MJRefeshHeader(refreshingBlock: refreshingBlock)
//        cmp.refreshingBlock = refreshingBlock
//        return cmp
//    }
//    
//    static func header(target: Any?, refreshingAction: Selector) -> MJRefeshHeader{
//       let cmp = MJRefeshHeader(target: target, refreshingAction: refreshingAction)
//       cmp.set(refreshingTarget: target, action: refreshingAction)
//       return cmp 
//    
//    }
    
    init(refreshingBlock: @escaping MJRefreshComponentRefreshingBlock) {
        super.init(frame: CGRect.zero)
        self.refreshingBlock = refreshingBlock
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(target: Any?, refreshingAction: Selector) {
        super.init(frame: CGRect.zero)
        self.set(refreshingTarget: target, action: refreshingAction)
    }
    
//    required init() {
//        super
//    }
//    init(refreshingBlock: @escaping MJRefreshComponentRefreshingBlock) {
//        self.refreshingBlock = refreshingBlock
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey{
        didSet{
           
        }
    }
    //MARK - 覆盖父类的方法
    override func prepare() {
        super.prepare()
        self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey
        self.mj_height = MJRefreshHeaderHeight
    }
    var ignoredScrollViewContentInsetTop: CGFloat = 0.0
    override func placeSubviews() {
        super.placeSubviews()
        self.mj_y = -self.mj_height - ignoredScrollViewContentInsetTop
    }
    var insetTDelta: CGFloat = 0.0
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
        if self.state == .refreshing {
            guard self.window != nil else {
                return
            }
            
            if let scrollView = self.scrollView {
                var insetT = -scrollView.mj_offsetY > self.scrollViewOriginalInset.top ? -scrollView.mj_offsetY : self.scrollViewOriginalInset.top
                
                insetT = insetT > self.mj_height + self.scrollViewOriginalInset.top ? self.mj_height + self.scrollViewOriginalInset.top : insetT
                scrollView.mj_insetTop = insetT
                self.insetTDelta = self.scrollViewOriginalInset.top - insetT
            }
            return
       }
    
        if let scrollView = self.scrollView{
            self.scrollViewOriginalInset = scrollView.contentInset
            let offSetY = scrollView.mj_offsetY
            let happenOffsetY = -self.scrollViewOriginalInset.top
            if offSetY > happenOffsetY {
                return
            }
            
            let normal2pullingOffsetY = happenOffsetY - self.mj_height
            let pullingPercent = (happenOffsetY-offSetY)/self.mj_height

            
            if scrollView.isDragging {
                self.pullingPercent = pullingPercent
                
                if self.state == .idle && offSetY < normal2pullingOffsetY {
                    self.state = .pulling
                }else if (self.state == .pulling && offSetY >= normal2pullingOffsetY){
                    self.state = .idle
                }
            }else if (self.state == .pulling){
                self.beginRefreshing()
            }else if (pullingPercent < 1){
                self.pullingPercent = pullingPercent
            }
        }
    }
    
    //MARK - set
    override var state: MJRefreshState  {
        
        didSet{
            guard let scrollView = self.scrollView else {
                return
            }
            if state == .idle {
                if oldValue != .refreshing {
                    return
                }
                UserDefaults.standard.set(Date(), forKey: self.lastUpdatedTimeKey)
                UserDefaults.standard.synchronize()
                UIView.animate(withDuration: MJRefreshSlowAnimationDuration, animations: { 
                    scrollView.mj_insetTop += self.insetTDelta
                    if self.autoChangeAlpha {
                        self.alpha = 0.0
                    }
                }, completion: { (finished) in
                    self.pullingPercent = 0.0;
                    if let endRefreshingCompletionBlock = self.endRefreshingCompletionBlock {
                        endRefreshingCompletionBlock()
                    }
                })
            }else if (state == .refreshing){
                DispatchQueue.main.async {
                    UIView.animate(withDuration: MJRefreshFastAnimationDuration, animations: { 
                        let top = self.scrollViewOriginalInset.top + self.mj_height
                        scrollView.mj_insetTop = top
                        scrollView.setContentOffset(CGPoint(x: 0, y: -top), animated: true)
                    }, completion: { (finished) in
                        self.executeRefreshingCallback()
                    })
                }
            }
        }
    }
    
    
    override func endRefreshing() -> Void {
        DispatchQueue.main.async {
            self.state = .idle
            
        }
    }
    
    
    var lastUpdatedTime: Date?{
        get{
            return (UserDefaults.standard.object(forKey: self.lastUpdatedTimeKey)) as? Date
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
