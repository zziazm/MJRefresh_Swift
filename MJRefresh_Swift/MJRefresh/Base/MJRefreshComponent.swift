//
//  MJRefreshComponent.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/19.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit
import Foundation
enum MJRefreshState: Int {
    case idle = 1 //普通闲置状态
    case pulling //松开就可以进行刷新的状态
    case refreshing //正在刷新中的状态
    case willRefresh //即将刷新的状态
    case noMoreData //所有数据加载完毕，没有更多的数据了
}
extension UILabel {
    static func mj_label() -> UILabel {
        let label = UILabel()
        label.font = MJRefreshLabelFont
        label.textColor = MJRefreshLabelTextColor

        label.autoresizingMask = .flexibleWidth
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        
        return label
    }
    
    func mj_textWith() -> CGFloat {
        
        var stringWidth: CGFloat = 0.0
        if let text = self.text {
            if text.characters.count > 0 {
                let  size = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
                stringWidth = (self.text?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.font], context: nil).size.width)!
            }
        }
       return stringWidth
    }
}



typealias MJRefreshComponentRefreshingBlock = ()->Void
typealias MJRefreshComponentbeginRefreshingCompletionBlock = ()->Void
typealias MJRefreshComponentEndRefreshingCompletionBlock = ()->Void


class MJRefreshComponent: UIView {
    

    var scrollViewOriginalInset = UIEdgeInsetsMake(0, 0, 0, 0)
    
    weak var scrollView: UIScrollView?
    
    var refreshingBlock: MJRefreshComponentRefreshingBlock?///正在刷新的回调
    
    var beginRefreshingCompletionBlock: MJRefreshComponentbeginRefreshingCompletionBlock?///开始刷新后的回调(进入刷新状态后的回调)
    
    var endRefreshingCompletionBlock: MJRefreshComponentEndRefreshingCompletionBlock? ///结束刷新的回调
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() -> Void {
        self.autoresizingMask = .flexibleWidth
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() -> Void {
        self.placeSubviews()
        super.layoutSubviews()
    }
    
    func placeSubviews() -> Void {
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super .willMove(toSuperview: newSuperview)
        if newSuperview != nil && !(newSuperview is UIScrollView){
            return
        }
        
        
        
        
    }
    
    func executeRefreshingCallback() -> Void {
        DispatchQueue.main.async {
            if let refreshingBlock = self.refreshingBlock {
                refreshingBlock()
            }
            
            if let beginRefreshingCompletionBlock = self.beginRefreshingCompletionBlock{
                beginRefreshingCompletionBlock()
            }
        }
    }
    
    var pullingPercent: CGFloat = 0.0{
        didSet{
            if self.isRefreshing() {
                return
            }
            
            if self.autoChangeAlpha {
                self.alpha = self.pullingPercent
            }
        }
    }
    
    var state: MJRefreshState = .idle {
        didSet{
            DispatchQueue.main.async {
                self.setNeedsLayout()
            }
        }
    }
    
    func beginRefreshing() -> Void {
        UIView.animate(withDuration: MJRefreshFastAnimationDuration) { 
            self.alpha = 1.0
        }
        self.pullingPercent = 1.0
        if self.window != nil {
            state = .refreshing
        }else {
            if state != .refreshing {
                state = .willRefresh
                self.setNeedsDisplay()
            }
        }
    }
    
    func beginRefreshingWithCompletionBlock(completionBlock: @escaping () -> Void) ->Void {
        beginRefreshingCompletionBlock = completionBlock
        self.beginRefreshing()
        
    }
    
    func endRefreshing() -> Void {
        state = .idle
    }
    
    func endRefreshingWithCompletionBlock(completionBlock: @escaping () -> Void) -> Void {
        endRefreshingCompletionBlock = completionBlock
        self.endRefreshing()
    }
    
    func isRefreshing() -> Bool {
        return state == .refreshing || state == .willRefresh
    }
    
    var autoChangeAlpha = false {
        didSet{
            if self.isRefreshing() {
                return
            }
            
            if autoChangeAlpha {
                self.alpha = self.pullingPercent
            }else{
                self.alpha = 1.0
            }

        }
    }
    
    
    var pan: UIPanGestureRecognizer?
    
    
    //MARK: - KVO监听
    func addObservers() -> Void {
        self.scrollView?.addObserver(self, forKeyPath: MJRefreshKeyPathContentOffset, options: [.new, .old], context: nil)
        self.scrollView?.addObserver(self, forKeyPath: MJRefreshKeyPathContentSize, options: [.new, .old], context: nil)
        self.pan = self.scrollView?.panGestureRecognizer
        self.pan?.addObserver(self, forKeyPath: MJRefreshKeyPathPanState, options: [.new, .old], context: nil)
    }
    
    func removeObservers() -> Void {
        self.scrollView?.removeObserver(self, forKeyPath: MJRefreshKeyPathContentOffset)
        self.scrollView?.removeObserver(self, forKeyPath: MJRefreshKeyPathContentSize)
        self.pan?.removeObserver(self, forKeyPath: MJRefreshKeyPathPanState)
        self.pan = nil
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !self.isUserInteractionEnabled {
            return
        }
        if let temKeyPath = keyPath  {
            if temKeyPath == MJRefreshKeyPathContentSize  {
                
            }
            
            if self.isHidden {
                return
            }
            
            if temKeyPath == MJRefreshKeyPathContentOffset {
                
            }else if temKeyPath == MJRefreshKeyPathPanState {
                
            }
        }
    }
    
    func scrollViewContentOffsetDidChange(change:[NSKeyValueChangeKey : Any]?) -> Void {
        
    }
    
    func scrollViewContentSizeDidChange(change:[NSKeyValueChangeKey : Any]?) -> Void {
        
    }
    
    func scrollViewPanStateDidChange(change:[NSKeyValueChangeKey : Any]?) -> Void {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
