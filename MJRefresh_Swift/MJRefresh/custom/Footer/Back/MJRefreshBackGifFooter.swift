//
//  MJRefreshBackGifFooter.swift
//  MJRefresh_Swift
//
//  Created by zm on 2017/8/2.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshBackGifFooter: MJRefreshBackStateFooter {
    lazy var gifView = UIImageView()
    
    lazy var stateImages = [MJRefreshState:[UIImage]]()
    
    lazy var stateDurations = [MJRefreshState:TimeInterval]()
    
    func set(images:[UIImage], duration:TimeInterval, for state: MJRefreshState) -> Void {
        
        self.stateImages[state] = images
        
        self.stateDurations[state] = duration
        
        if let image = images.first {
            if  image.size.height > self.mj_height {
                self.mj_height = image.size.height
            }
        }
    }
    
    func set(images:[UIImage], for state: MJRefreshState) -> Void {
        self.set(images: images, duration: TimeInterval(images.count) * 0.1, for: state)
    }
    
    override func prepare() {
        super.prepare()
        self.addSubview(gifView)
        self.labelLeftInset = 20
    }
    
    override var pullingPercent: CGFloat{
        didSet{
            if let images = self.stateImages[.idle] {
                if self.state != .idle {
                    return
                }
                
                self.gifView.stopAnimating()
                
                var index = Int (CGFloat(images.count) * pullingPercent)
                if index >= images.count {
                    index = images.count - 1
                }
                self.gifView.image = images[index]
            }
            
        }
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.gifView.constraints.count > 0 {
            return
        }
        
        self.gifView.frame = self.bounds
        if self.stateLabel.isHidden{
            self.gifView.contentMode = .center
        }else{
            self.gifView.contentMode = .right
            self.gifView.mj_width = self.mj_width * 0.5 - self.labelLeftInset - self.stateLabel.mj_textWith() * 0.5
        }
    }
    
    
    override var state: MJRefreshState{
        didSet{
            if state == .pulling || state == .refreshing {
                if let images = self.stateImages[state] {
                    self.gifView.isHidden = false
                    self.gifView.stopAnimating()
                    
                    if images.count == 1 {
                        self.gifView.image = images.last
                    }else{
                        self.gifView.animationImages = images
                        if let duration = self.stateDurations[state] {
                            self.gifView.animationDuration = duration
                        }
                        self.gifView.startAnimating()
                    }
                }
            }else if state == .idle{
                self.gifView.isHidden = false
            } else if state == .noMoreData  {
                self.gifView.isHidden = true
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
