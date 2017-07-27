//
//  MJRefreshGifHeader.swift
//  MJRefresh_Swift
//
//  Created by 赵铭 on 2017/7/24.
//  Copyright © 2017年 zm. All rights reserved.
//

import UIKit

class MJRefreshGifHeader: MJRefreshStateHeader {
    lazy var gifView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    var stateImages = [MJRefreshState:[UIImage]]()
    var stateDurations = [MJRefreshState:TimeInterval]()
    
    func set(images: [UIImage], duration: TimeInterval, _for state: MJRefreshState) -> Void {
        if images.count == 0 {
            return
        }
        self.stateImages[state] = images
        self.stateDurations[state] = duration
        if let image = images.first {
            self.mj_height = image.size.height
        }
    }
    
    func set(images: [UIImage], _for state: MJRefreshState) -> Void {
        self.set(images: images, duration: TimeInterval(images.count) * 0.1, _for: state)
    }
    
    override func prepare() {
        super.prepare()
        self.addSubview(self.gifView)
        self.labelLeftInset = 20
    }
    
    override var pullingPercent: CGFloat{
        didSet{
            guard let images = self.stateImages[.idle] else {
                return
            }
            
            if self.state != .idle || images.count == 0 {
                return
            }
            
            self.gifView.stopAnimating()
            var  index = Int(CGFloat(images.count) * pullingPercent)
            print(index, pullingPercent)

            if index >= images.count {
                index = images.count  - 1
            }
            print(index, pullingPercent)
            self.gifView.image = images[index]
            
        }
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        if self.gifView.constraints.count > 0 {
            return
        }
        self.gifView.frame = self.bounds
        if self.stateLabel.isHidden && self.lastUpdatedTimeLabel.isHidden{
            self.gifView.contentMode = .center
        }else{
            self.gifView.contentMode = .right
            let stateWidth = self.stateLabel.mj_textWith()
            var timeWidth: CGFloat = 0.0
            
            if !self.lastUpdatedTimeLabel.isHidden {
                timeWidth = self.lastUpdatedTimeLabel.mj_textWith()
            }
            
            let textWidth = max(stateWidth, timeWidth)
            self.gifView.mj_width = self.mj_width * 0.5 - textWidth * 0.5 - self.labelLeftInset
        }
    }
    
    
    override var state: MJRefreshState {
        didSet{
            if state == .pulling || state == .refreshing{
                let images = self.stateImages[state]
                if images?.count == 0 {
                    return
                }
                
                self.gifView.stopAnimating()
                
                if images?.count == 1 {
                    self.gifView.image = images?.last
                }else{
                    self.gifView.animationImages = images
                    if let animationDuration = self.stateDurations[state]{
                        self.gifView.animationDuration = animationDuration
                    }
                    self.gifView.startAnimating()
                }
            }else if state == .idle{
                self.gifView.stopAnimating() 
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
